//
//  File.swift
//  
//
//  Created by kazunori.aoki on 2023/07/10.
//

import Foundation
import Vapor

struct SystemMessage: Content {
    var message: String
}

extension SystemMessage {
    static func create(from gpt: ChatGptResponse) -> Self {
        guard let message = gpt.choices.first?.message.content else { fatalError() }
        return .init(message: message)
    }
}
