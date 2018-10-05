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
 "Title":"Batman Begins",
 "Year":"2005",
 "imdbID":"tt0372784",
 "Type":"movie",
 "Poster": "https://m.media-amazon.com/images/M/ MV5BZmUwNGU2ZmItMmRiNC00MjhlLTg5YWUtODMyNzkxODYzMmZlXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg"
 */
struct OMDBResponse: Codable {
    var title: String?
    var year: String?
    var imdbID: String?
    var type: String?
    var posterUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case posterUrl = "Poster"
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        year = try values.decode(String.self, forKey: .year)
        title = try values.decode(String.self, forKey: .title)
        year = try values.decode(String.self, forKey: .year)
    }
}

extension OMDBResponse: CustomDebugStringConvertible {
    var debugDescription: String {
        return "<title: \n \(title)\n> year:\n \(year)\n with imdbID\n \(imdbID)\n  and type:\n \(type)\n and Poster url:\n \(posterUrl)"
    }
}
