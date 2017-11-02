//
//  String+Localized.swift
//  prototype1
//
//  Created by Swift Mage on 02/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation
import UIKit

extension String {
//  var localized: String {
//    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
//  }

  func localize(withComment comment: String) -> String {
    return NSLocalizedString(self, comment: comment)
  }
}

