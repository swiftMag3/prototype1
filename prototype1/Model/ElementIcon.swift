//
//  ElementIcon.swift
//  prototype1
//
//  Created by Swift Mage on 03/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation

class ElementIcon {
  let atomicNumber: Int
  let elementSymbol: String
  let elementName: String
  let elementGroup: String
  let elementIUPAC: String
  let elementLocation: TableLocation
  let cpkColor: String?
  
  /// Localized version of name properties
  var localizedName: String {
    let name = self.elementName
    return nameForElement[name] ?? name
  }
  
  /// Localized version of group
  var localizedGroup: String {
    let group = self.elementGroup
    return groupForElement[group] ?? group
  }
  
  /// Localized version of iupac name
  var localizedIUPAC: String {
    let iupac = self.elementIUPAC
    return iupacForElement[iupac] ?? iupac
    
  }
  
  
  
  init(atomicNumber: Int, elementSymbol: String, elementName: String, elementGroup: String, elementIUPAC: String, elementLocation: TableLocation, cpkColor: String?) {
    self.atomicNumber = atomicNumber
    self.elementSymbol = elementSymbol
    self.elementName = elementName
    self.elementGroup = elementGroup
    self.elementIUPAC = elementIUPAC
    self.elementLocation = elementLocation
    self.cpkColor = cpkColor
  }
  
  convenience init() {
    self.init(atomicNumber: 0, elementSymbol: "", elementName: "", elementGroup: "", elementIUPAC: "", elementLocation: TableLocation(row: 0, column: 0), cpkColor: nil)
  }
}
