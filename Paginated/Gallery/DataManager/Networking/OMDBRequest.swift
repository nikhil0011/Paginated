
//
//  OMDBRequest
//  Paginated
//
//  Created by Admin on 10/5/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

struct OMDBRequest {
    static private let privateKey = "eeefc96f"

  var path: String {
    return ""
  }
  
  let parameters: Parameters
  private init(parameters: Parameters) {
    self.parameters = parameters
  }
}

extension OMDBRequest {
  static func from() -> OMDBRequest {
    let defaultParameters = ["s": "Batman", "apikey": privateKey]
    return OMDBRequest(parameters: defaultParameters)
  }
}
