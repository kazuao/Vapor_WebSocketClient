//
//  WebSocketClient.swift
//  VaporWebSocketClient
//
//  Created by kazunori.aoki on 2023/07/11.
//

import Foundation
import Starscream

final class WsClient {
    static let shared = WsClient()

    private var messageHandler: ((Data) -> Void)?
    var message: AsyncStream<Data> {
        return .init { continuation in
            self.messageHandler = { value in
                continuation.yield(value)
            }
        }
    }

    private var socket: WebSocket!

    func open() async throws {
        guard let url = URL(string: "ws://<ローカルIPアドレス>:8080/chat") else {
            fatalError()
        }

        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }()

        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }

    func close() {
        socket.disconnect()
        socket = nil
    }

    func request(param: Data) {
        guard socket != nil else { return }
        let s = String(data: param, encoding: .utf8)!
        socket.write(string: s)
    }
}

extension WsClient: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .text(let string):
            guard let data = string.data(using: .utf8) else { return }
            messageHandler?(data)

        default: break
        }
    }
}
