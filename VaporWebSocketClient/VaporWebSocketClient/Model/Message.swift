//
//  Message.swift
//  VaporWebSocketClient
//
//  Created by kazunori.aoki on 2023/07/11.
//

import Foundation

enum ActorType {
    case user, system
}

struct Message: Identifiable, Equatable {
    var id: UUID = .init()
    var actor: ActorType
    var text: String
}

extension Message {
    static func create(from systemMessage: SystemMessage) -> Self {
        return .init(
            actor: .system,
            text: systemMessage.message
        )
    }
}
