//
//  LegendView.swift
//  prototype1
//
//  Created by Swift Mage on 12/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
@IBDesignable
class LegendView: UIView {

  
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        LegendKit.drawLegend()
  }
 

}
