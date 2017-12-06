//
//  GroupedCollectionViewCell.swift
//  prototype1
//
//  Created by Swift Mage on 08/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class GroupedCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var atomicNumberLabel: UILabel!
  @IBOutlet weak var atomicMassLabel: UILabel!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  
  var element: ElementRealm?
  
  override func prepareForReuse() {
    DispatchQueue.main.async {
      let width = Constant.collectionViewCellWidth.rawValue
      self.layer.cornerRadius = CGFloat(Int(width/4))
      self.layer.masksToBounds = true
      self.displayElement(nil)
    }
  }
  
  func updateAppearanceFor(_ element: ElementRealm?, animated: Bool = true) {
    DispatchQueue.main.async {
      let width = Constant.collectionViewCellWidth.rawValue
      self.layer.cornerRadius = CGFloat(Int(width/4))
      self.layer.masksToBounds = true
      if animated {
        UIView.animate(withDuration: 0.25) {
          self.displayElement(element)
        }
      } else {
        self.displayElement(element)
      }
    }
  }
  
  private func displayElement(_ element: ElementRealm?) {
    self.element = element
    var cpkColor: String
    
    if let theElement = element {
      cpkColor = theElement.cpkHexColor
      backgroundColor = UIColor(hex: cpkColor)
      label.text = theElement.symbol
      label.alpha = 1.0
      atomicNumberLabel.text = "\(theElement.atomicNumber)"
      atomicNumberLabel.alpha = 1.0
      atomicMassLabel.text = String(format: "%.0f", theElement.atomicMass)
      atomicMassLabel.alpha = 1.0
      loadingIndicator?.alpha = 0
      loadingIndicator?.stopAnimating()
      label.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: backgroundColor!)
      atomicMassLabel.textColor = label.textColor
      atomicNumberLabel.textColor = label.textColor
    } else {
      backgroundColor = UIColor.lightGray
      label.alpha = 0.0
      atomicNumberLabel.alpha = 0.0
      atomicMassLabel.alpha = 0.0
      loadingIndicator?.alpha = 1.0
      loadingIndicator?.startAnimating()
    }
    
  }
}
