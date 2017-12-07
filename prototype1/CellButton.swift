//
//  CellButton.swift
//  prototype1
//
//  Created by Swift Mage on 06/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import RealmSwift
import QuartzCore

class CellButton: UIButton {
  
  var atomicNumber: Int = 0
  private var elementName: String = ""
  private var buttonFrame: CGRect = CGRect()
  
  convenience init(atomicNumber: Int) {
    self.init()
    self.atomicNumber = atomicNumber
  }
    
  func setupButton() {
    let realmObjects = try! Realm().objects(ElementRealm.self)[atomicNumber-1]
    setupFrame()
    self.frame = buttonFrame
    self.setTitle(realmObjects.symbol, for: .normal)
    self.setTitleColor(.black, for: .normal)
    self.setTitleColor(.lightGray, for: .highlighted)
    self.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
    self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    self.layer.borderWidth = 0.25
    self.layer.borderColor = UIColor.black.cgColor
  }
  
  private func setupFrame() {
    let width = 35
    switch atomicNumber {
    case 1:
      buttonFrame = CGRect(x: 39, y: 615, width: width, height: width)
    case 2:
      buttonFrame = CGRect(x: 39, y: 20, width: width, height: width)
    case 3, 4:
      let base = 3
      let y = 615 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 74, y: y, width: width, height: width)
    case 5, 6, 7, 8, 9, 10:
      let base = 5
      let y = 195 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 74, y: y, width: width, height: width)
    case 11, 12:
      let base = 11
      let y = 615 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 109, y: y, width: 35, height: 35)
    case 13, 14, 15, 16, 17, 18:
      let base = 13
      let y = 195 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 109, y: y, width: width, height: width)
    case 19...36:
      let base = 19
      let y = 615 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 144, y: y, width: width, height: width)
    case 37...54:
      let base = 37
      let y = 615 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 179, y: y, width: width, height: width)
    case 55, 56:
      let base = 55
      let y = 615 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 214, y: y, width: width, height: width)
    case 57...71:
      let base = 57
      let y = 510 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 295, y: y, width: width, height: width)
    case 72...86:
      let base = 72
      let y = 510 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 214, y: y, width: width, height: width)
    case 87, 88:
      let base = 87
      let y = 615 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 249, y: y, width: width, height: width)
    case 89...103:
      let base = 89
      let y = 510 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 330, y: y, width: width, height: width)
    case 104...118:
      let base = 104
      let y = 510 - (atomicNumber - base) * width
      buttonFrame = CGRect(x: 249, y: y, width: width, height: width)
    default:
      buttonFrame = CGRect(x: 39, y: 615, width: 35, height: 35)
    }
  }
  

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
