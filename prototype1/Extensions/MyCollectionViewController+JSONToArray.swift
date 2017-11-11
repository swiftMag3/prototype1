//
//  MyCollectionViewController+JSONToArray.swift
//  prototype1
//
//  Created by Swift Mage on 01/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation
import SwiftyJSON

extension MyCollectionViewController {
  
  func loadIconsData(handler: @escaping ([ElementIcon]) -> ()) {

    guard let data = try? Data(contentsOf: targetData) else {
      debugPrint("Error: Could not load the data.json in document directory".localize(withComment: "Error message"))
      return
    }
    
    var iconsData: [ElementIcon] = []
    
    let json = JSON(data)
    let totalElements = json["result"].arrayValue.count
    
    for index in 0..<totalElements {
      let result = json["result"][index]
      let atomicNumber = result["atomicNumber"].intValue
      let elementSymbol = result["symbol"].stringValue
      let elementName = result["name"].stringValue
      let elementGroup = result["groupBlock", "legacy"].stringValue
      let elementIUPAC = result["groupBlock", "iupac"].string ?? "Unknown"
      let tableRow = result["location", "row"].intValue
      let tableColumn = result["location", "column"].intValue
      let elementLocation = TableLocation(row: tableRow, column: tableColumn)
      let cpkColor = result["cpkHexColor"].string
      let atomicMass = result["atomicMass"].doubleValue
      
      let iconData = ElementIcon(atomicNumber: atomicNumber, elementSymbol: elementSymbol, elementName: elementName, elementGroup: elementGroup, elementIUPAC: elementIUPAC, elementLocation: elementLocation, cpkColor: cpkColor, atomicMass: atomicMass)
      iconsData.append(iconData)
    }
    
    handler(iconsData)
  }
}

