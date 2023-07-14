//
//  File.swift
//  
//
//  Created by kazunori.aoki on 2023/07/11.
//

import Foundation

enum HogeError: Error {
    case error
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol RestParamProtocol {
    associatedtype Request: Codable
    associatedtype Response: Codable

    var baseUrl: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var params: Request? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension RestParamProtocol {

    func buildUrlRequest() throws -> URLRequest {
        guard let baseUrl = URL(string: baseUrl) else {
            throw HogeError.error
        }

        let url = baseUrl.appendingPathComponent(path)

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var urlRequest = URLRequest(url: url)

        if let queryItems {
            components?.queryItems = queryItems
        }

        if params != nil, let params = try? JSONEncoder().encode(params) {
            urlRequest.httpBody = params
        }

        if let body {
            urlRequest.httpBody = body
        }

        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue

        if let headers {
            for header in headers {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }

        return urlRequest
    }

    func response(from data: Data) throws -> Response {
        if Response.self is String.Type {
            return data.base64EncodedString() as! Response
        } else {
            return try JSONDecoder().decode(Response.self, from: data)
        }
    }
}
