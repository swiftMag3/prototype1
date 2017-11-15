//
//  ElementsDataSource.swift
//  prototype1
//
//  Created by Swift Mage on 14/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ElementsDataSource {
  fileprivate var elements: [Element_] = []
  fileprivate var sections: [String] = []
  var allElements: [Element_] = []
  
  var count: Int {
    return elements.count
  }
  
  var numbersOfSection: Int {
    return sections.count
  }
  
  init() {
    elements = loadDataFromDisk()
    allElements = elements
  }
  
  func indexPathForPark(_ element: Element_) -> IndexPath {
    let section = sections.index(of: element.legacyBlock)!
    var item = 0
    for (index, currentElement) in elementsForSection(section).enumerated() {
      if element === currentElement {
        item = index
        break
      }
    }
    return IndexPath(item: item, section: section)
  }
  
  func elementForItemAtIndexPath(_ indexPath: IndexPath) -> Element_? {
    if indexPath.section >= 0 {
      let elements = elementsForSection(indexPath.section)
      return elements[indexPath.item]
    } else {
      return elements[indexPath.item]
    }
  }
  
  func numberOfElementsInSection(_ index: Int) -> Int {
    let elements = elementsForSection(index)
    return elements.count
  }
  
  func titleForSectionAtIndexPath(_ indexPath: IndexPath) -> String {
    if indexPath.section < sections.count {
      return sections[indexPath.section].capitalized
    }
    return UnknownValue.string
  }
  
  private func elementsForSection(_ index: Int) -> [Element_] {
    let section = sections[index].lowercased()
    let elementsInSection = elements.filter { (element: Element_) -> Bool in
      return element.localizedGroup.lowercased() == section
    }
    if index == 0 {
      for item in elementsInSection {
        print(item.name, item.localizedGroup)
      }
    }
    return elementsInSection
  }
  
  private func copyLocalJSONtoDocumentDirectory() {
    guard let bundledJSON = Bundle.main.url(forResource: "data",
                                            withExtension: "json"),
      let jsonData = try? Data(contentsOf: bundledJSON) else {
        debugPrint("data.json is not in the bundle")
        return
    }
    do {
      try jsonData.write(to: targetData, options: .atomic)
      debugPrint("file copied successfully")
    } catch let error as NSError{
      print(error)
    }
  }
  
  private func loadDataFromDisk() -> [Element_]{
    if !FileManager.default.fileExists(atPath: targetData.path) {
      copyLocalJSONtoDocumentDirectory()
    } else {
      debugPrint("data.json already exists")
    }
    
    guard let data = try? Data(contentsOf: targetData) else {
      print("Error: Could not load the data.json in document directory".localize(withComment: "Error message"))
      return []
    }
    
    var elements: [Element_] = []
    let json = JSON(data)
    let arrayCount = json["result"].arrayValue.count
    
    // Mark: - Setting The Properties
    for index in 0..<arrayCount {
      let result = json["result"][index]
      // Element ID
      let atomicNumber = result["atomicNumber"].intValue
      let symbol = result["symbol"].stringValue
      let name = result["name"].stringValue
      let cpkHexColor = result["cpkHexColor"].string ?? "ffffff"
      let legacyBlock = result["groupBlock", "legacy"].stringValue
      let iupacBlock = result["groupBlock", "iupac"].string ?? legacyBlock
      let yearDiscovered = result["yearDiscovered"].stringValue
      let tableRow = result["location", "row"].intValue
      let tableColumn = result["location", "column"].intValue
      let elementPosition = TableLocation(row: tableRow, column: tableColumn)
      
      // Basic Properties
      let atomicMass = result["atomicMass"].doubleValue
      let standardState = result["standardState"].stringValue
      let density = result["density"].double
      let electronConfiguration = result["electronicConfiguration"].stringValue
      let valence = result["valence"].intValue
      let meltingPoint = result["meltingPoint"].double
      let boilingPoint = result["boilingPoint"].double
      let bondingType = result["bondingType"].string ?? UnknownValue.string
      
      // Advanced Properties
      let electronegativity = result["electronegativity"].double
      let electronAffinity = result["electronAffinity"].double
      let ionizationEnergy = result["ionizationEnergy"].double
      let oxidationStates = result["oxidationStates"].string ?? UnknownValue.string
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
      
      let newElement = Element_(atomicNumber: atomicNumber, symbol: symbol, name: name, cpkHexColor: cpkHexColor, iupacBlock: iupacBlock, legacyBlock: legacyBlock, yearDiscovered: yearDiscovered, elementPosition: elementPosition, atomicMass: atomicMass, standardState: standardState, density: density, electronicConfiguration: electronConfiguration, valence: valence, meltingPoint: meltingPoint, boilingPoint: boilingPoint, bondingType: bondingType, electronegativity: electronegativity, electronAffinity: electronAffinity, ionizationEnergy: ionizationEnergy, oxidationStates: oxidationStates, atomicRadius: atomicRadius, hardness: hardness, modulus: modulus, conductivity: conductivity, heatProperties: heatProperties, abundance: abundace)
      if !sections.contains(newElement.localizedGroup) {
        sections.append(newElement.localizedGroup)
      }
      
      elements.append(newElement)
    }
    return elements
  }
}

