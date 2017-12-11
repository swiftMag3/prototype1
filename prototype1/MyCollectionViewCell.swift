//
//  MyCollectionViewCell.swift
//  prototype1
//
//  Created by Swift Mage on 01/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import Chameleon


class MyCollectionViewCell: UICollectionViewCell {
  @IBOutlet private weak var label: UILabel!
  @IBOutlet private weak var atomicNumberLabel: UILabel!
  @IBOutlet private weak var atomicMassLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  
  var element: ElementRealm?
  private var shadowLayer = CAShapeLayer()
  
  override func prepareForReuse() {
    DispatchQueue.main.async {
      self.displayElement(nil)
      self.shadowLayer.removeFromSuperlayer()
    }
  }
  
  func updateAppearanceFor(_ element: ElementRealm?, animated: Bool = true) {
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
  
  override var isHighlighted: Bool {
    didSet {
      if isHighlighted {
        UIView.animate(withDuration: 0.1, animations: {
          self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
      } else {
        UIView.animate(withDuration: 0.1, animations: {
          self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
      }
    }
  }
  
  private func displayElement(_ element: ElementRealm?) {
    self.element = element
    var cpkColor: String


    
    if let theElement = element {
      // Shadow
      shadowLayer = CAShapeLayer()
      shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
      shadowLayer.fillColor = UIColor.clear.cgColor
      shadowLayer.shadowColor = UIColor.darkGray.cgColor
      shadowLayer.shadowPath = shadowLayer.path
      shadowLayer.shadowOffset = CGSize(width: 0, height: 3)
      shadowLayer.shadowOpacity = 0.3
      shadowLayer.shadowRadius = 2
      layer.insertSublayer(shadowLayer, below: nil)
      
      // Cell set up
      cpkColor = theElement.cpkHexColor
      backgroundColor = UIColor(hex: cpkColor).add(overlay: UIColor(hex: "E1E6E5").withAlphaComponent(0.5))
      label.text = theElement.symbol
      label.alpha = 1.0
      atomicNumberLabel.text = "\(theElement.atomicNumber)"
      atomicNumberLabel.alpha = 1.0
      atomicMassLabel.text = String(format: "%.1f", theElement.atomicMass)
      atomicMassLabel.alpha = 1.0
      label.textColor = UIColor.adjustColor(textColor: UIColor.black.add(overlay: UIColor.lightGray.withAlphaComponent(0.4)), withBackground: backgroundColor!)
      atomicMassLabel.textColor = label.textColor
      atomicNumberLabel.textColor = label.textColor
      nameLabel.alpha = 1
      nameLabel.text = theElement.localizedName
      nameLabel.textColor = label.textColor
      
      nameLabel.superview?.backgroundColor = backgroundColor
      nameLabel.superview?.layer.cornerRadius = layer.cornerRadius
      
    } else {
//      backgroundColor = UIColor.clear
      label.alpha = 0.0
      atomicNumberLabel.alpha = 0.0
      atomicMassLabel.alpha = 0.0
      nameLabel.alpha = 0.0
      nameLabel.superview?.backgroundColor = UIColor.white
    }
    
  }
}
