import Fluent
import Vapor
import WebSocketKit

func routes(_ app: Application) {

    app.webSocket("chat") { req, ws in
        let controller = Controller()

        ws.onText { ws, text in
            Task {
                let responseMessage = await controller.onText(text)
                try! await ws.send(responseMessage)
            }
        }

        Task {
            try! await Task.sleep(nanoseconds: UInt64(2 * 1_000_000_000))

            let m = SystemMessage(message: "Hi! ChatGPTに質問を送るよ！なにか質問文を送ってね！")
            let encoded = try JSONEncoder().encode(m)
            try! await ws.send(String(data: encoded, encoding: .utf8)!)
        }
    }
}
