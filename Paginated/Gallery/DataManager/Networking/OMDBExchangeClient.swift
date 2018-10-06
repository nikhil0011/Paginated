//
//  OMDBExchangeClient.swift
//  Paginated
//
//  Created by Admin on 10/5/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

final class OMDBExchangeClient {
    private lazy var baseURL: URL = {
        return URL(string: "https://www.omdbapi.com/")!
    }()
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchMoviesPost(with request: OMDBRequest, page: Int, completion: @escaping (Result<OMDBResponse, DataResponseError>) -> Void) {
        // 1
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        // 2
        let parameters = ["page": "\(page)"].merging(request.parameters, uniquingKeysWith: +)
        // 3
        let encodedURLRequest = urlRequest.encode(with: parameters)
        
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            debugPrint("JSON", response)
            debugPrint("data",data)
            // 4
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {

                    
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            // 5
            guard let decodedResponse = try? JSONDecoder().decode(OMDBResponse.self, from: data) else {
                debugPrint("Decoding Error")
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            debugPrint("decodedResponse",decodedResponse)
            // 6
            completion(Result.success(decodedResponse))
        }).resume()
    }
}

