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

@testable import DistributedActors
import DistributedActorsTestKit
@testable import Logging
import XCTest

final class DeadLetterTests: ClusterSystemXCTestCase {
    // ==== ------------------------------------------------------------------------------------------------------------
    // MARK: DeadLetterOffice tests

    func test_deadLetters_logWithSourcePosition() throws {
        let log = self.logCapture.logger(label: "/dead/letters")

        let id = try ActorID(local: self.system.cluster.uniqueNode, path: ActorPath._user.appending("someone"), incarnation: .random())
        let office = DeadLetterOffice(log, id: id, system: system)

        office.deliver("Hello")

        try self.logCapture.awaitLogContaining(self.testKit, text: "was not delivered to [\"/user/someone")
    }

    // ==== ------------------------------------------------------------------------------------------------------------
    // MARK: ClusterSystem integrated tests

    func test_sendingToTerminatedActor_shouldResultInDeadLetter() throws {
        let ref: _ActorRef<String> = try self.system._spawn(
            "ludwig",
            .receiveMessage { _ in
                .stop
            }
        )
        let p = self.testKit.makeTestProbe(expecting: Never.self)

        p.watch(ref)
        ref.tell("terminate please")
        try p.expectTerminated(ref)

        ref.tell("Are you still there?")

        try self.logCapture.awaitLogContaining(self.testKit, text: "Are you still there?")
        try self.logCapture.awaitLogContaining(self.testKit, text: "/user/ludwig")
    }

    func test_askingTerminatedActor_shouldResultInDeadLetter() throws {
        let ref: _ActorRef<String> = try self.system._spawn(
            "ludwig",
            .receiveMessage { _ in
                .stop
            }
        )
        let p = self.testKit.makeTestProbe(expecting: Never.self)

        p.watch(ref)
        ref.tell("terminate please")
        try p.expectTerminated(ref)

        sleep(1)

        let answer = ref.ask(for: String.self, timeout: .milliseconds(100)) { replyTo in
            "This is a question, reply to \(replyTo)"
        }

        _ = try shouldThrow {
            try answer.wait()
        }

        try self.logCapture.awaitLogContaining(self.testKit, text: "This is a question")
        try self.logCapture.awaitLogContaining(self.testKit, text: "/user/ludwig")
    }
}
