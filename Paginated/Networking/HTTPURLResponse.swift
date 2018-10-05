//
//  HTTPURLResponse.swift
//  Paginated
//
//  Created by Admin on 10/5/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
