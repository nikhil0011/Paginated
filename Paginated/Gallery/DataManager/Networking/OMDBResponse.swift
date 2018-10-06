//
//  OMDBResponse.swift
//  Paginated
//
//  Created by Admin on 10/5/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

/*
 *
 "Search":[],
 "totalResults":"345",
 "Response":"True"
 */
struct OMDBResponse: Codable {
    var search: Array<MoviesPost>?
    var totalResults: String?
    var response: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case response = "Response"
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search = try values.decode(Array<MoviesPost>.self, forKey: .search)
        response = try values.decode(String.self, forKey: .response)
    }
}

extension OMDBResponse: CustomDebugStringConvertible {
    var debugDescription: String {
        return "<search: \n \(String(describing: search))\n> totalResults:\n \(String(describing: totalResults)) and response : \(String(describing: response))"
    }
}
