//
//  MyCollectionViewCell.swift
//  prototype1
//
//  Created by Swift Mage on 01/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
  @IBOutlet private weak var label: UILabel!
  @IBOutlet private weak var atomicNumberLabel: UILabel!
  @IBOutlet private weak var atomicMassLabel: UILabel!
  @IBOutlet private weak var shadowView: UIView!
  @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
  
  var element: ElementRealm?
  
  override func prepareForReuse() {
    DispatchQueue.main.async {
      self.displayElement(nil)
    }
  }
  
  func updateAppearanceFor(_ element: ElementRealm?, animated: Bool = false) {
    DispatchQueue.main.async {
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
  
  func addShadow() {
    shadowView.layer.shadowColor = UIColor.lightGray.cgColor
    shadowView.layer.shadowOpacity = 1
    shadowView.layer.shadowOffset = CGSize.zero
    shadowView.layer.shadowRadius = 10
    shadowView.layer.masksToBounds = false
    shadowView.layer.shouldRasterize = true
  }
}
