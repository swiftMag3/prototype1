//
//  MyCollectionViewController+JSONToArray.swift
//  prototype1
//
//  Created by Swift Mage on 01/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation
import SwiftyJSON
//////
var dictString: String = "****"
var arrayOfGroup: [String] = []
/////
extension MyCollectionViewController {
  func loadDatabaseInArray() -> [Element] {
    guard let data = try? Data(contentsOf: targetData) else { return [Element]() }
    
    var elements: [Element] = []

    let json = JSON(data)
    let totalElements = json["result"].arrayValue.count

    
    for index in 0..<totalElements {
      let result = json["result"][index]
      
      // Element ID
      let atomicNumber = result["atomicNumber"].intValue
      let symbol = result["symbol"].stringValue
      let name = result["name"].stringValue
      let cpkHexColor = result["cpkHexColor"].string
      let legacyBlock = result["groupBlock", "legacy"].stringValue
      let iupacBlock = result["groupBlock", "iupac"].string
      let yearDiscovered = result["yearDiscovered"].stringValue
      let tableRow = result["location", "row"].intValue
      let tableColumn = result["location", "column"].intValue
      let elementPosition = TableLocation(row: tableRow, column: tableColumn)
      
      let elementID = ElementID(atomicNumber: atomicNumber,
                                symbol: symbol,
                                name: name,
                                cpkHexColor: cpkHexColor,
                                iupacBlock: iupacBlock,
                                legacyBlock: legacyBlock,
                                yearDiscovered: yearDiscovered,
                                elementPosition: elementPosition)
      
      // Basic Properties
      let atomicMass = result["atomicMass"].doubleValue
      let standardState = result["standardState"].stringValue
      let density = result["density"].double
      let electronConfiguration = result["electronicConfiguration"].stringValue
      let valence = result["valence"].intValue
      let meltingPoint = result["meltingPoint"].double
      let boilingPoint = result["boilingPoint"].double
      let bondingType = result["bondingType"].string
      
      let basicProperties = BasicProperties(atomicMass: atomicMass,
                                            standardState: standardState,
                                            density: density,
                                            electronicConfiguration: electronConfiguration,
                                            valence: valence,
                                            meltingPoint: meltingPoint,
                                            boilingPoint: boilingPoint,
                                            bondingType: bondingType)
      
      // Advanced Properties
      let electronegativity = result["electronegativity"].double
      let electronAffinity = result["electronAffinity"].double
      let ionizationEnergy = result["ionizationEnergy"].double
      let oxidationStates = result["oxidationStates"].string
      //AtomicRadius
      let vanDerWaals = result["atomicRadius", "vanDerWaals"].double
      let empirical = result["atomicRadius", "empirical"].double
      let calculated = result["atomicRadius", "calculated"].double
      let covalent = result["atomicRadius", "covalent"].double
      let ion = result["ionRadius"].dictionaryObject as? [String: Double]
      //Hardness
      let vickers = result["hardness", "vickers"].double
      let mohs = result["hardness", "mohs"].double
      let brinell = result["hardness", "brinell"].double
      //Modulus
      let young = result["modulus", "young"].double
      let shear = result["modulus", "shear"].double
      let bulk = result["modulus", "bulk"].double
      //Conductivity
      let electric = result["conductivity", "electric"].double
      let thermal = result["conductivity", "thermal"].double
      //Heat
      let specificHeat = result["heat", "specific"].double
      let vaporizationHeat = result["heat", "vaporization"].double
      let fusionHeat = result["heat", "fusion"].double
      //Abundance
      let inUniverse = result["abundance", "universe"].double
      let inSolar = result["abundance", "solar"].double
      let inMeteor = result["abundance", "meteor"].double
      let inCrust = result["abundance", "crust"].double
      let inOcean = result["abundance", "ocean"].double
      let inHuman = result["abundance", "human"].double
      
      
      
      
      let atomicRadius = AtomicRadius(vanDerWaals: vanDerWaals,
                                      empirical: empirical,
                                      calculated: calculated,
                                      covalent: covalent,
                                      ion: ion)
      
      let hardness = Hardness(vickers: vickers,
                              mohs: mohs,
                              brinell: brinell)
      let modulus = Modulus(young: young, shear: shear, bulk: bulk)
      let conductivity = Conductivity(electric: electric, thermal: thermal)
      let heatProperties = HeatProperties(specificHeat: specificHeat,
                                          vaporizationHeat: vaporizationHeat,
                                          fusionHeat: fusionHeat)
      let abundace = Abundance(inUniverse: inUniverse,
                               inSolar: inSolar,
                               inMeteor: inMeteor,
                               inCrust: inCrust,
                               inOcean: inOcean,
                               inHuman: inHuman)
      
      let advancedProperties = AdvancedProperties(electronegativity: electronegativity,
                                                  electronAffinity: electronAffinity,
                                                  ionizationEnergy: ionizationEnergy,
                                                  oxidationStates: oxidationStates,
                                                  atomicRadius: atomicRadius,
                                                  hardness: hardness,
                                                  modulus: modulus,
                                                  conductivity: conductivity,
                                                  heatProperties: heatProperties,
                                                  abundace: abundace)
      
      let newElement = Element(elementID: elementID,
                               basicProperties: basicProperties,
                               advancedProperties: advancedProperties)
      elements.append(newElement)
    }
    return elements
  }
}
