//
//  File.swift
//  
//
//  Created by kazunori.aoki on 2023/07/11.
//

import Foundation

struct ChatGptResponse: Codable {
    var id: String
    var object: String
    var created: Int
    var model: String
    var choices: [Choice]
    var usage: Usage

    struct Choice: Codable {
        var index: Int
        var message: ChatGptRequest.Message
        var finishReason: String

        enum CodingKeys: String, CodingKey {
            case index
            case message
            case finishReason = "finish_reason"
        }
    }

    struct Usage: Codable {
        var promptTokens: Int
        var completionTokens: Int
        var totalTokens: Int

        enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case completionTokens = "completion_tokens"
            case totalTokens = "total_tokens"
        }
    }
}
