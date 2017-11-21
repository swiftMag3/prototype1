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

extension Formatter {
  static let decimal: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.usesSignificantDigits = true
    formatter.minimumSignificantDigits = 1
    formatter.maximumSignificantDigits = 4
    return formatter
  }()
}

extension Numeric {
  var decimalFormatted: String {
    return Formatter.decimal.string(for: self) ?? ""
  }
}

