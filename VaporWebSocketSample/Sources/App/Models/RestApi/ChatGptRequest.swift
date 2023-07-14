//
//  File.swift
//  
//
//  Created by kazunori.aoki on 2023/07/11.
//

import Foundation

struct ChatGptRequest: Codable {
    var model: String
    var messages: [Message]

    struct Message: Codable {
        var role: String
        var content: String
    }
}

extension ChatGptRequest {
    static func create(text: String) -> Self {
        let message = ChatGptRequest.Message(role: "user", content: text)
        let request = ChatGptRequest(model: "gpt-3.5-turbo", messages: [message])
        return request
    }
}
