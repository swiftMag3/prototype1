//
//  MyCollectionViewCell.swift
//  prototype1
//
//  Created by Swift Mage on 01/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var atomicNumberLabel: UILabel!
  @IBOutlet weak var atomicMassLabel: UILabel!
  @IBOutlet weak var shadowView: UIView!
  
  var element: ElementIcon?
  
  override func prepareForReuse() {
    label.text = ""
  }
  
  func addShadow() {
    shadowView.layer.shadowColor = UIColor.lightGray.cgColor
    shadowView.layer.shadowOpacity = 1
    shadowView.layer.shadowOffset = CGSize.zero
    shadowView.layer.shadowRadius = 10
    shadowView.layer.masksToBounds = false
    shadowView.layer.shouldRasterize = true
  }
}
