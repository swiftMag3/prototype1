//
//  UIColor+blending.swift
//  prototype1
//
//  Created by Swift Mage on 07/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  
  func add(overlay: UIColor) -> UIColor {
    var bgR: CGFloat = 0
    var bgG: CGFloat = 0
    var bgB: CGFloat = 0
    var bgA: CGFloat = 0
    
    var fgR: CGFloat = 0
    var fgG: CGFloat = 0
    var fgB: CGFloat = 0
    var fgA: CGFloat = 0
    
    self.getRed(&bgR, green: &bgG, blue: &bgB, alpha: &bgA)
    overlay.getRed(&fgR, green: &fgG, blue: &fgB, alpha: &fgA)
    
    let r = fgA * fgR + (1 - fgA) * bgR
    let g = fgA * fgG + (1 - fgA) * bgG
    let b = fgA * fgB + (1 - fgA) * bgB
    
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
  }
  
  static func +(lhs: UIColor, rhs: UIColor) -> UIColor {
    return lhs.add(overlay: rhs)
  }
}
