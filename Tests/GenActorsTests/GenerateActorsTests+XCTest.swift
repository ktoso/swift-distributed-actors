//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Distributed Actors open source project
//
// Copyright (c) 2019 Apple Inc. and the Swift Distributed Actors project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.md for the list of Swift Distributed Actors project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import XCTest

///
/// NOTE: This file was generated by generate_linux_tests.rb
///
/// Do NOT edit this file directly as it will be regenerated automatically when needed.
///

extension GenerateActorsTests {
    static var allTests: [(String, (GenerateActorsTests) -> () throws -> Void)] {
        return [
            ("test_TestActorable_greet", test_TestActorable_greet),
            ("test_TestActorable_greet_underscoreParam", test_TestActorable_greet_underscoreParam),
            ("test_TestActorable_greet2", test_TestActorable_greet2),
            ("test_TestActorable_greetReplyToActorRef", test_TestActorable_greetReplyToActorRef),
            ("test_TestActorable_greetReplyToActor", test_TestActorable_greetReplyToActor),
            ("test_TestActorable_greetReplyToReturnStrict", test_TestActorable_greetReplyToReturnStrict),
            ("test_TestActorable_greetReplyToReturnStrictThrowing", test_TestActorable_greetReplyToReturnStrictThrowing),
            ("test_TestActorable_greetReplyToReturnNIOFuture", test_TestActorable_greetReplyToReturnNIOFuture),
            ("test_ClassActorableInstance", test_ClassActorableInstance),
            ("test_codableMessage_skipGeneration", test_codableMessage_skipGeneration),
            ("test_LifecycleActor_doesNotContainUnderscorePrefixedMessage", test_LifecycleActor_doesNotContainUnderscorePrefixedMessage),
            ("test_LifecycleActor_doesNotContainGeneratedMessagesForLifecycleMethods", test_LifecycleActor_doesNotContainGeneratedMessagesForLifecycleMethods),
            ("test_TestActorable_doesNotContainGenerated_privateFuncs", test_TestActorable_doesNotContainGenerated_privateFuncs),
            ("test_TestActorable_becomeAnotherBehavior", test_TestActorable_becomeAnotherBehavior),
            ("test_combinedProtocols_receiveEitherMessage", test_combinedProtocols_receiveEitherMessage),
            ("test_combinedProtocols_passAroundAsOnlyAPartOfTheProtocol", test_combinedProtocols_passAroundAsOnlyAPartOfTheProtocol),
            ("test_LifecycleActor_shouldReceiveLifecycleEvents", test_LifecycleActor_shouldReceiveLifecycleEvents),
            ("test_LifecycleActor_watchActorsAndReceiveTerminationSignals", test_LifecycleActor_watchActorsAndReceiveTerminationSignals),
        ]
    }
}
