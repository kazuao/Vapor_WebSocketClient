//
//  UserMessage.swift
//  VaporWebSocketClient
//
//  Created by kazunori.aoki on 2023/07/11.
//

import Foundation

struct UserMessage: Codable {
    var message: String
}

extension UserMessage {
    static func create(_ text: String) -> UserMessage {
        return .init(message: text)
    }
}
