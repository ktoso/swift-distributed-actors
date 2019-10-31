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

/// Allows for defining actor behaviors using normal `func` syntax, in which case all `public` and `internal` functions
/// are made available as message sends of the corresponding names and parameters.
///
/// ***Usage:*** Define your actor behavior using normal functions as you would with any other struct or class in Swift,
/// and then use the `GenActors` tool to generate the required infrastructure to bridge the `Actorable` into the messaging runtime.
/// This step is best automated as a pre-compile step in your SwiftPM project.
///
/// Note that it is NOT possible to invoke any of the methods on defined on the `Actorable` instance directly when run as an actor,
/// as that would lead to potential concurrency issues. Thankfully, all function calls made on an `Actor` returned by
/// invoking `ActorSystem.spawn(name:actorable:)` are automatically translated in safe message dispatches.
///
/// ***NOTE:*** It is our hope to replace the code generation needed here with language features in Swift itself.
public protocol Actorable {
    associatedtype Message
    associatedtype ActorableContext = ActorContext<Message>

    static func makeBehavior(instance: Self) -> Behavior<Message>

    init(context: ActorableContext)
}

/// Wraps a reference to an actor.
///
/// All function calls made on this object are turned into message sends and delivered *asynchronously* to the underlying actor.
///
/// It is safe (including thread-safe) to share the `Actor` object with other threads, as well as to share it across the network.
public struct Actor<A: Actorable> {
    /// Underlying `ActorRef` to the actor running the `Actorable` behavior.
    public let ref: ActorRef<A.Message>

    public init(ref: ActorRef<A.Message>) {
        self.ref = ref
    }
}
