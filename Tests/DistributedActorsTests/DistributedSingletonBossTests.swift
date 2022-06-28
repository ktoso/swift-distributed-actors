//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Distributed Actors open source project
//
// Copyright (c) 2018-2022 Apple Inc. and the Swift Distributed Actors project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.md for the list of Swift Distributed Actors project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import Distributed
@testable import DistributedActors
import DistributedActorsTestKit
import Foundation
import XCTest

typealias DefaultDistributedActorSystem = ClusterSystem

distributed actor ThereCanBeOnlyOne {
    let probe: ActorTestProbe<String>?

    init(probe: ActorTestProbe<String>?, actorSystem: ActorSystem) {
        self.actorSystem = actorSystem
        self.probe = probe
    }

    distributed func forward(message: String) -> String {
        self.probe?.tell("\(self.id) forwarded: \(message)")
        return "echo: \(message)"
    }
}


final class DistributedSIngletonBossTests: ClusterSystemXCTestCase {
    
    func test_receptionist_listing_shouldRespondWithRegisteredRefsForKey() async throws {
        try await shouldNotThrow {
            
            let p = testKit.makeTestProbe(expecting: String.self)
            
            let singleton = DistributedSingletonBoss(actorSystem: system)
            
            // this node is not hosting instances, but wants to find a singleton of this type
            let justProxy: ThereCanBeOnlyOne = try await singleton.proxy(ThereCanBeOnlyOne.self) // TODO: tagging ("singleton for 'fish' tag)
            
            // we can either host or proxy; depends what the singleton allocation strategy decides:
            let hostOrProxy: ThereCanBeOnlyOne = try await singleton.host(ThereCanBeOnlyOne.self) { actorSystem in
                return .init(probe: p, actorSystem: actorSystem)
            }
            
            let intercept = SingletonCallInterceptor(ThereCanBeOnlyOne.self, through: boss, id: proxy.id)
            let reply = try await _Props.$forSpawn.withValue(.withRemoteCallInterceptor(intercept)) {
                try await proxy.forward(message: "Hello")
            }
            reply.shouldContain("echo: Hello")
            
            try p.expectMessage(prefix: "KAPPA")
        }
    }
}
