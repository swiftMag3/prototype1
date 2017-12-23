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

enum DisplayType {
  case normal
  case density
  case atomicRadius
  case electronegativity
  case meltingPoint
  case boilingPoint
  case ionization
}

class CellButton: UIButton {
  
  var atomicNumber: Int = 0
  private var elementName: String = ""
  private var buttonFrame: CGRect = CGRect()
  
  func setupButton(for element: Int, withPercentageFor displayType: DisplayType = DisplayType.normal) {
    
    atomicNumber = element
    let realmObject = try! Realm().objects(ElementRealm.self)[element-1]
    var percentage = 100.0
    setupFrame()
    
    switch displayType {
    case .density:
      percentage = realmObject.densityComparationFraction
    case .atomicRadius:
      percentage = realmObject.atomicRadiusComparationFraction
    case .boilingPoint:
      percentage = realmObject.boilingPointComparationFraction
    case .electronegativity:
      percentage = realmObject.electronegativityComparationFraction
    case .meltingPoint:
      percentage = realmObject.meltingPointComparationFraction
    case .ionization:
      percentage = realmObject.ionizationEnergyComparationFraction
    default:
      percentage = 100
    }
    
    setPercentageBoxInReverse(withPercentageFor: percentage)
    self.frame = buttonFrame
    self.setTitle(realmObject.symbol, for: .normal)
    self.setTitleColor(.black, for: .normal)
    self.setTitleColor(.lightGray, for: .highlighted)
    self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    self.layer.borderWidth = 0.25
    self.layer.borderColor = UIColor.black.cgColor
  }
  
  func setPercentageBoxInReverse(withPercentageFor percentage: Double) {
    let multiplier = CGFloat(1 - percentage/100)
    let box = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: multiplier*35))
    box.backgroundColor = UIColor.white
    
    // Set the subview for no interaction so touches can pass through it
    box.isUserInteractionEnabled = false
    self.addSubview(box)
  }
    
  private func setupFrame() {
    let width = 35
    switch atomicNumber {
    case 1:
      buttonFrame = CGRect(x: 17, y: 40, width: width, height: width)
    case 2:
      buttonFrame = CGRect(x: 612, y: 40, width: width, height: width)
    case 3, 4:
      let base = 3
      let x = 17 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 75, width: width, height: width)
    case 5, 6, 7, 8, 9, 10:
      let base = 5
      let x = 437 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 75, width: width, height: width)
    case 11, 12:
      let base = 11
      let x = 17 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 110, width: 35, height: 35)
    case 13, 14, 15, 16, 17, 18:
      let base = 13
      let x = 437 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 110, width: width, height: width)
    case 19...36:
      let base = 19
      let x = 17 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 145, width: width, height: width)
    case 37...54:
      let base = 37
      let x = 17 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 180, width: width, height: width)
    case 55, 56:
      let base = 55
      let x = 17 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 215, width: width, height: width)
    case 57...71:
      let base = 57
      let x = 122 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 296, width: width, height: width)
    case 72...86:
      let base = 72
      let x = 122 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 215, width: width, height: width)
    case 87, 88:
      let base = 87
      let x = 17 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 250, width: width, height: width)
    case 89...103:
      let base = 89
      let x = 122 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 331, width: width, height: width)
    case 104...118:
      let base = 104
      let x = 122 + (atomicNumber - base) * width
      buttonFrame = CGRect(x: x, y: 250, width: width, height: width)
    default:
      buttonFrame = CGRect(x: 87, y: 215, width: 35, height: 35)
    }
  }
}
