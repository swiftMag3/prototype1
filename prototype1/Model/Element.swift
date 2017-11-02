//
//  Element.swift
//  prototype1
//
//  Created by Swift Mage on 26/10/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation

class Element {
  let elementID: ElementID
  let basicProperties: BasicProperties
  let advancedProperties: AdvancedProperties
  var isMarked: Bool = false
  
  init(elementID: ElementID, basicProperties: BasicProperties, advancedProperties: AdvancedProperties) {
    self.elementID = elementID
    self.basicProperties = basicProperties
    self.advancedProperties = advancedProperties
  }
}


