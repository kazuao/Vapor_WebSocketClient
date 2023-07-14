//
//  File.swift
//  
//
//  Created by kazunori.aoki on 2023/07/11.
//

import Foundation

actor Controller {
    private let client = RestApiClient()

    func onText(_ text: String) async -> String {
        guard let data = text.data(using: .utf8),
              let decode = try? JSONDecoder().decode(UserMessage.self, from: data)
        else { fatalError() }

        let systemMessage = try! await request(userMessage: decode)
        let encoded = try! JSONEncoder().encode(systemMessage)
        return String(data: encoded, encoding: .utf8)!
    }

    private func request(userMessage: UserMessage) async throws -> SystemMessage {
        let param = ChatGptRequestParam(text: userMessage.message)
        let request = try param.buildUrlRequest()
        let response = try await client.request(urlRequest: request)
        let decoded = try param.response(from: response)
        return .create(from: decoded)
    }
}
