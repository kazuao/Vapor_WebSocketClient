//
//  ViewModel.swift
//  VaporWebSocketClient
//
//  Created by kazunori.aoki on 2023/07/11.
//

import Foundation

final class ViewModel: ObservableObject {
    private let client = WsClient()
    private var task: Task<Void, Never>?

    @Published var messages: [Message] = []

    init() {
        setup()
    }

    deinit {
        task?.cancel()
        client.close()
    }

    private func setup() {

        task = Task {
            guard task?.isCancelled == false else { return }

            try! await client.open()

            for await data in client.message {
                let decoded = try! JSONDecoder().decode(SystemMessage.self, from: data)
                let message = Message.create(from: decoded)
                
                Task.detached { @MainActor in
                    self.messages.append(message)
                }
            }
        }
    }

    func sendMessage(text: String) {

        messages.append(.init(actor: .user, text: text))

        let param = UserMessage.create(text)
        let data = try! JSONEncoder().encode(param)
        client.request(param: data)
    }
}
