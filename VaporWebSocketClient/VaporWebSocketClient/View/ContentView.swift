//
//  ContentView.swift
//  VaporWebSocketClient
//
//  Created by kazunori.aoki on 2023/07/11.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel: ViewModel = .init()

    @State private var text: String = ""

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 20) {

                        Spacer()
                            .frame(height: 20)

                        ForEach(viewModel.messages) { message in
                            MessageView(message: message)
                                .padding(.horizontal, 30)
                        }
                    }
                }
                .onChange(of: viewModel.messages.count) { _ in
                    withAnimation(.easeInOut) {
                        if let id = viewModel.messages.last?.id {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
            }

            TextArea()
        }
        .background(Color.background)
    }

    @ViewBuilder
    func MessageView(message: Message) -> some View {
        HStack {
            if message.actor == .user {
                Spacer()
                    .frame(minWidth: UIScreen.main.bounds.width * 0.2)
            }

            Text(message.text)
                .font(.body)
                .foregroundColor(message.actor == .user ? .white : .black)
                .padding(20)
                .background(
                    message.actor == .user
                    ? RoundedCorners(type: .user)
                    : RoundedCorners(type: .system)
                )
                .layoutPriority(1)

            if (message.actor == .system) {
                Spacer()
                    .frame(minWidth: UIScreen.main.bounds.width * 0.2)
            }
        }
    }

    @ViewBuilder
    func TextArea() -> some View {
        HStack {
            TextField("質問を入力してください", text: $text)
                .frame(height: 36)
                .padding(4)
                .background(.white)
                .cornerRadius(4)

            Button {
                sendMessage()
            } label: {
                Image(systemName: "paperplane.fill")
                    .frame(width: 44, height: 44)
                    .foregroundColor(Color.background)
                    .background(Color.userMessageBackground)
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal, 30)
    }

    private func sendMessage() {
        if text.isEmpty { return }
        viewModel.sendMessage(text: text)
        text = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
