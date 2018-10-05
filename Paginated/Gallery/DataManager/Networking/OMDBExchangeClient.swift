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
    
    func fetchModerators(with request: OMDBRequest, page: Int, completion: @escaping (Result<OMDBResponse, DataResponseError>) -> Void) {
    }
}

