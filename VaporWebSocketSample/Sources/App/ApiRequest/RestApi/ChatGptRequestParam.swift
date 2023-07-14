//
//  File.swift
//  
//
//  Created by kazunori.aoki on 2023/07/11.
//

import Foundation

let CHAT_GPT_KEY = ""

struct ChatGptRequestParam: RestParamProtocol {
    typealias Request = ChatGptRequest
    typealias Response = ChatGptResponse

    var text: String

    var baseUrl: String {
        return "https://api.openai.com"
    }

    var path: String {
        return "/v1/chat/completions"
    }

    var method: HttpMethod {
        return .post
    }

    var headers: [String : String]? {
        return [
            "Authorization": "Bearer \(CHAT_GPT_KEY)",
            "Content-Type": "application/json",
        ]
    }

    var params: ChatGptRequest? {
        return .create(text: text)
    }

    var queryItems: [URLQueryItem]? = nil

    var body: Data? = nil
}
