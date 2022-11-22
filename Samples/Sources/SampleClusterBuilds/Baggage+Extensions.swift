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

import Tracing
import DistributedCluster

extension Baggage {
    static func withActor<Act: DistributedActor, T>(_ actor: Act, operation: () async throws -> T) async rethrows -> T where Act.ID == ClusterSystem.ActorID {
        let baggage = Baggage.withActor(actor)
        return try await Baggage.$current.withValue(baggage) {
            try await operation()
        }
    }
    static func withActor<Act: DistributedActor, T>(_ actor: Act, operation: () throws -> T) rethrows -> T where Act.ID == ClusterSystem.ActorID {
        let baggage = Baggage.withActor(actor)
        return try Baggage.$current.withValue(baggage) {
            try operation()
        }
    }

    static func withActor<Act: DistributedActor>(_ actor: Act) -> Baggage where Act.ID == ClusterSystem.ActorID {
        var baggage = Baggage.current ?? .topLevel
        baggage.clusterActorID = actor.id
        return baggage
    }
}
