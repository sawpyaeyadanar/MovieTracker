//
//  APIService.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 12/1/68 BE.
//

import Combine
import Foundation

class APIService {
    private init() {}
    static let shared = APIService()

    func request<T: Decodable>(_ endpoint: APIEndPoint, parameters: [String: String] = [:]) -> AnyPublisher<T, APIError> {
        var urlComponent = endpoint.urlComponent
        urlComponent.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponent.queryItems?.append(URLQueryItem(name: "api_key", value: URLManager.apiKey))
        
        guard let url = urlComponent.url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.url?.appendPathComponent(endpoint.path)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addHeaders(endpoint.headers)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        debugPrint("URL ", request.url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> T in
                guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    throw APIError.failedRequest
                }
                return try JSONDecoder().decode(T.self, from: data)
            }
            .mapError { error -> APIError in
                switch error {
                case URLError.notConnectedToInternet:
                    return .notConnectedToInternet
                case let DecodingError.keyNotFound(key, context):
                    return .decodingKeyNotFoundError(key: key, context: context.debugDescription)
                case let DecodingError.valueNotFound(value, context):
                    return .decodingValueNotFoundError(key: value, context: context.debugDescription)
                case let DecodingError.typeMismatch(type, context):
                    return .decodingTypeMismatchError(key: type, context: context.debugDescription)
                case let DecodingError.dataCorrupted(context):
                    return .dataCorrupted(context)
                default:
                    return .failedRequest
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
