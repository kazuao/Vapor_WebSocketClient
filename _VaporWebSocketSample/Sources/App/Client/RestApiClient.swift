//
//  File.swift
//  
//
//  Created by kazunori.aoki on 2023/07/11.
//

import Foundation

actor RestApiClient {
    func request(urlRequest: URLRequest) async throws -> Data {
        async let (data, _) = URLSession.shared.data(for: urlRequest)
        return try await data
    }
}
