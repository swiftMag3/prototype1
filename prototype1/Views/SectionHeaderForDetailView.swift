//
//  SectionHeaderForDetailView.swift
//  prototype1
//
//  Created by Swift Mage on 09/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class SectionHeaderForDetailView: UICollectionReusableView {
  @IBOutlet private weak var label: UILabel!
  
  var title: String? {
    didSet {
      label.text = title
    }
  }
  
  func rotateLabel() {
    label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
  }
}

