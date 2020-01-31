//
//  RandomAPIClient.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import Combine

class RandomAPIClient {
    
    private let baseURL = URL(string: "https://randomuser.me/")
    private static let seed = "qonto"
    
    func fetchUserList(forPage page: UInt = 1, seed: String = seed) -> AnyPublisher<[RandomUser], Error> {
        guard let url = self.getEscapedURL(withPath: "api") else {
            return Fail<[RandomUser], Error>(error: RandomAPIError.invalidURL).eraseToAnyPublisher()
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let parameters: [String: Any] = [
            "page": page,
            "seed": seed,
            "results": 10,
//            "inc": ["id","name","email"].joined(separator: ",")
        ]
        components?.queryItems = parameters
            .mapValues { String(describing: $0).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) }
            .compactMap { $0 as? (key: String, value: String) }
            .map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let componentsURL = components?.url else {
            return Fail<[RandomUser], Error>(error: RandomAPIError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: componentsURL)
        request.httpMethod = "get"
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .retry(1)
            .map(\.data)
            .decode(type: RandomAPIResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .eraseToAnyPublisher()
    }
    
    /// Get escaped URL from path
    private func getEscapedURL(withPath path: String) -> URL? {
        var fixedPath: String = path
        if fixedPath.first == "/" { fixedPath.removeFirst() }
        guard let safePath = fixedPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return URL(string: safePath, relativeTo: self.baseURL)
    }
}
