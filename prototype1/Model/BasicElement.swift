//
//  BasicElement.swift
//  prototype1
//
//  Created by Swift Mage on 01/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation

class BasicElement {
  let atomicNumber: Int
  let symbol: String
  let name: String
  let cpkHexColor: String?
  let legacyBlock: String
  let elementPosition: TableLocation
  
  init(atomicNumber: Int,
       symbol: String,
       name: String,
       cpkColor: String?,
       block: String,
       position: TableLocation) {
    self.atomicNumber = atomicNumber
    self.symbol = symbol
    self.name = name
    self.cpkHexColor = cpkColor
    self.legacyBlock = block
    self.elementPosition = position
  }
}
