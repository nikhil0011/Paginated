//
//  String+Extension.swift
//  Paginated
//
//  Created by Admin on 10/5/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import UIKit
extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
}


extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}
