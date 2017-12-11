//
//  PeriodicTableBackgroundView.swift
//  prototype1
//
//  Created by Swift Mage on 06/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
@IBDesignable
class PeriodicTableBackgroundView: UIView {
  
  override func draw(_ rect: CGRect) {
//    PeriodicTableBackground.drawPeriodicTablePortrait()
    PeriodicTableBackground.drawPeriodicTableLandscape()
  }
  
  
}
