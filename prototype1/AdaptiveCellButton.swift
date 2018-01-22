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
import Chameleon

private struct Constants {
  static var topHeaderHeight: CGFloat = 30
  static var transitionTopMargin: CGFloat =  Constants.topHeaderHeight + 3
}

struct Cache {
  static let hydrogenColor: UIColor = UIColor(red: 0.933, green: 0.152, blue: 0.891, alpha: 1.000)
  static let alkaliMetalsColor: UIColor = UIColor(red: 1.000, green: 0.862, blue: 0.483, alpha: 1.000)
  static let alkalineEarthMetalsColor: UIColor = UIColor(red: 0.996, green: 0.998, blue: 0.409, alpha: 1.000)
  static let transitionMetalsColor: UIColor = UIColor(red: 0.892, green: 0.780, blue: 0.782, alpha: 1.000)
  static let postTransitionMetalColor: UIColor = UIColor(red: 0.569, green: 0.827, blue: 0.762, alpha: 1.000)
  static let metalloidsColor: UIColor = UIColor(red: 0.464, green: 0.869, blue: 0.532, alpha: 1.000)
  static let otherNonMetalsColor: UIColor = UIColor(red: 0.125, green: 1.000, blue: 0.127, alpha: 1.000)
  static let nobleGasesColor: UIColor = UIColor(red: 0.464, green: 0.800, blue: 0.999, alpha: 1.000)
  static let unknownColor: UIColor = UIColor(red: 0.890, green: 0.890, blue: 0.890, alpha: 1.000)
  static let lanthanoidsColor: UIColor = UIColor(red: 1.000, green: 0.777, blue: 0.661, alpha: 1.000)
  static let actinoidsColor: UIColor = UIColor(red: 0.932, green: 0.735, blue: 0.866, alpha: 1.000)
  static let gradientColor: UIColor = UIColor(red: 0.512, green: 0.860, blue: 0.526, alpha: 1.000)
}

class AdaptiveCellButton: UIButton {
  
  var atomicNumber: Int = 0
  private var elementName: String = ""
  private var buttonFrame: CGRect = CGRect()
  
  func setupButton(for element: Int, withPercentageFor displayType: DisplayType = DisplayType.normal, inView containerView: UIView) {
    
    atomicNumber = element
    let realmObject = try! Realm().objects(ElementRealm.self)[element-1]
    var percentage = 100.0
    
    // calculating optimal width
    var width = Int(containerView.frame.width / 18)
    let height = Int((containerView.frame.height - Constants.topHeaderHeight - Constants.transitionTopMargin) / 9)
    width = min(width, height)
    let margin = (Int(containerView.frame.width) - (width * 18)) / 2
    
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
    
//    setPercentageBoxInReverse(withPercentageFor: percentage)
    
    let multiplier = CGFloat(1 - percentage/100)
    let box = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(width), height: multiplier*CGFloat(width)))
    box.backgroundColor = UIColor.white
    
    // Set the subview for no interaction so touches can pass through it
    box.isUserInteractionEnabled = false
    self.addSubview(box)
    
    
    switch (realmObject.elementColumn, realmObject.elementRow)  {
    case (3,6), (3,7):
      var x = 0
      var y = 0
      if realmObject.atomicNumber <= 71 {
        x = margin + (2 + (realmObject.atomicNumber - 57)) * width
        y = Int(Constants.transitionTopMargin) + 7 * width
      } else if realmObject.atomicNumber >= 89 {
        x = margin + (2 + (realmObject.atomicNumber - 89)) * width
        y = Int(Constants.transitionTopMargin) + 8 * width
      }
      frame = CGRect(x: x, y: y, width: width, height: width)
      
    default:
      let x = margin + (realmObject.elementColumn - 1) * width
      let y = Int(Constants.topHeaderHeight) + (realmObject.elementRow - 1) * width
      frame = CGRect(x: x, y: y, width: width, height: width)
    }
    
    // Background color based on element type
    switch realmObject.legacyBlock.lowercased() {
    case "nonmetal":
      backgroundColor = Cache.otherNonMetalsColor
    case "noble gas":
      backgroundColor = Cache.nobleGasesColor
    case "alkali metal":
      backgroundColor = Cache.alkaliMetalsColor
    case "alkaline earth metal":
      backgroundColor = Cache.alkalineEarthMetalsColor
    case "metalloid":
      backgroundColor = Cache.metalloidsColor
    case "transition metal":
      backgroundColor = Cache.transitionMetalsColor
    case "lanthanoid":
      backgroundColor = Cache.lanthanoidsColor
    case "actinoid":
      backgroundColor = Cache.actinoidsColor
    case "post-transition metal", "metal":
      backgroundColor = Cache.postTransitionMetalColor
    default:
      backgroundColor = Cache.unknownColor
    }
    
    self.setTitle(realmObject.symbol, for: .normal)
    self.setTitleColor(.black, for: .normal)
    self.setTitleColor(.lightGray, for: .highlighted)
    self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    self.layer.borderWidth = 0.25
    self.layer.cornerRadius = CGFloat(round(Double(width / 8)))
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.setTitleColor(UIColor.init(contrastingBlackOrWhiteColorOn:
      self.backgroundColor, isFlat: false), for: .normal)
    
    // Add atomic number label
    let atomicNumberLabel = UILabel(frame: CGRect(x: 2, y: 2, width: self.frame.width - 5, height: 8))
    atomicNumberLabel.text = "\(realmObject.atomicNumber)"
    atomicNumberLabel.font = UIFont.systemFont(ofSize: 8)
    atomicNumberLabel.textColor = UIColor.init(contrastingBlackOrWhiteColorOn: self.backgroundColor, isFlat: false)
    addSubview(atomicNumberLabel)
    
  }
  
  func setPercentageBoxInReverse(withPercentageFor percentage: Double) {
    let multiplier = CGFloat(1 - percentage/100)
    let box = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: multiplier*35))
    box.backgroundColor = UIColor.white
    
    // Set the subview for no interaction so touches can pass through it
    box.isUserInteractionEnabled = false
    self.addSubview(box)
  }
}

