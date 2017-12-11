//
//  ElementsRealmDataSource.swift
//  prototype1
//
//  Created by Swift Mage on 05/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import RealmSwift

class ElementsRealmDataSource {
  private var sections: [String] = []
  
  var count: Int {
    let realm = try! Realm().objects(ElementRealm.self)
    return realm.count
  }
  
  var numbersOfSection: Int {
    return sections.count
  }
  
  init() {
    do {
      if try Realm().isEmpty {
        writeElementsToRealm()
        populateComparationFractions()
        print("Realm is written")
      } else {
        print("Realm already exists")
      }
    } catch {
      print("Error writing from JSON to Realm: \(error)")
    }
    sectionsOfElements()
  }
  
  private func sectionsOfElements() {
    let realm = try! Realm()
    let elements = realm.objects(ElementRealm.self)
    for element in elements {
      if !sections.contains(element.localizedGroup) {
        sections.append(element.localizedGroup)
      }
    }
  }
  
  func elementForItemAtIndexPath(_ indexPath: IndexPath) -> ElementRealm? {
    let realm = try! Realm()
    let section = sections[indexPath.section].lowercased()
    
    // Localization workaround -> because localized versions are not saved in Realm object
    var sectionName: String = ""
    for (key, value) in groupForElement {
      if value.lowercased() == section {
        sectionName = key
      }
    }
    
    // Realm Query
    let predicate = NSPredicate(format: "legacyBlock == %@", sectionName)
    if indexPath.section >= 0 {
      let elements = realm.objects(ElementRealm.self).filter(predicate)
      let elementForItem = elements[indexPath.item]
      return elementForItem
    } else {
      let elements = realm.objects(ElementRealm.self)
      return elements[indexPath.item]
    }
  }
  
  func numberOfElementsInSection(_ index: Int) -> Int {
    let realm = try! Realm()
    let section = sections[index].lowercased()
    let elements = realm.objects(ElementRealm.self).filter { (element) -> Bool in
      element.localizedGroup.lowercased() == section
    }
    return elements.count
  }
  
  func titleForSectionAtIndexPath(_ indexPath: IndexPath) -> String {
    if indexPath.section < sections.count {
      return sections[indexPath.section].capitalized
    }
    return UnknownValue.string
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

  
  private func writeElementsToRealm() {
//
//    if !FileManager.default.fileExists(atPath: targetData.path) {
//      copyLocalJSONtoDocumentDirectory()
//    } else {
//      debugPrint("data.json already exists")
//    }
    copyLocalJSONtoDocumentDirectory()
    
    guard let data = try? Data(contentsOf: targetData) else {
      print("Error: Could not load the data.json in document directory".localize(withComment: "Error message"))
      return
    }
    
    
    let json = JSON(data)
    let arrayCount = json["result"].arrayValue.count
    let realm = try! Realm()
    
    for index in 0..<arrayCount {
      let element = ElementRealm()
      let result = json["result"][index]
      
      element.atomicNumber = result["atomicNumber"].intValue
      element.symbol = result["symbol"].stringValue
      element.name = result["name"].stringValue
      element.cpkHexColor = result["cpkHexColor"].string ?? "ff1493"
      element.legacyBlock = result["groupBlock", "legacy"].stringValue
      element.iupacBlock = result["groupBlock", "iupac"].string ?? element.legacyBlock
      element.yearDiscovered = result["yearDiscovered"].stringValue
      element.elementRow = result["location", "row"].intValue
      element.elementColumn = result["location", "column"].intValue
      
      element.atomicMass = result["atomicMass"].doubleValue
      element.standardState = result["standardState"].stringValue
      element.density.value = result["density"].double
      element.electronicConfiguration = result["electronicConfiguration"].stringValue
      element.valence = result["valence"].intValue
      element.meltingPoint.value = result["meltingPoint"].double
      element.boilingPoint.value = result["boilingPoint"].double
      element.bondingType = result["bondingType"].string ?? UnknownValue.string
      
      element.electronegativity.value = result["electronegativity"].double
      element.electronAffinity.value = result["electronAffinity"].double
      element.ionizationEnergy.value = result["ionizationEnergy"].double
      element.oxidationStates = result["oxidationStates"].string ?? UnknownValue.string
      
      element.vanDerWaalsRadius.value = result["atomicRadius", "vanDerWaals"].double
      element.empiricalRadius.value = result["atomicRadius", "empirical"].double
      element.calculatedRadius.value = result["atomicRadius", "calculated"].double
      element.covalentRadius.value = result["atomicRadius", "covalent"].double
      element.vickersHardness.value = result["hardness", "vickers"].double
      element.mohsHardness.value = result["hardness", "mohs"].double
      element.brinellHardness.value = result["hardness", "brinell"].double
      element.youngModulus.value = result["modulus", "young"].double
      element.shearModulus.value = result["modulus", "shear"].double
      element.bulkModulus.value = result["modulus", "bulk"].double
      
      element.electricalConductivity.value = result["conductivity", "electric"].double
      element.thermalConductivity.value = result["conductivity", "thermal"].double
      element.specifictHeat.value = result["heat", "specific"].double
      element.vaporizationHeat.value = result["heat", "vaporization"].double
      element.fusionHeat.value = result["heat", "fusion"].double
      
      element.abundanceInUniverse.value = result["abundance", "universe"].double
      element.abundanceInSolar.value = result["abundance", "solar"].double
      element.abundanceInMeteor.value = result["abundance", "meteor"].double
      element.abundanceInCrust.value  = result["abundance", "crust"].double
      element.abundanceInOcean.value = result["abundance", "ocean"].double
      element.abundaceInHuman.value = result["abundance", "human"].double
      
      // Adding a dictionary of ionRadius to the object
      let ionDictionary = result["ionRadius"].dictionaryObject as? [String: Double]
      if let ionDictionary = ionDictionary {
        for (key, value) in ionDictionary {
          let ionRadius = IonRadius(ion: key, radius: value)
          element.ionRadius.append(ionRadius)
        }
      }
      
      do {
        try realm.write {
          realm.add(element, update: true)
        }
      } catch {
        print("Can't write to Realm with error : \(error)")
      }
    }
  }
  
  private func populateComparationFractions() {
    let realm = try! Realm()
    let realmResult = realm.objects(ElementRealm.self)
    let maxDensity = realmResult.sorted(byKeyPath: "density").last?.density.value
    let maxAtomicRadius = realmResult.sorted(byKeyPath: "calculatedRadius").last?.calculatedRadius.value
    let maxElectronegativity = realmResult.sorted(byKeyPath: "electronegativity").last?.electronegativity.value
    let maxMeltingPoint = realmResult.sorted(byKeyPath: "meltingPoint").last?.meltingPoint.value
    let maxBoilingPoint = realmResult.sorted(byKeyPath: "boilingPoint").last?.boilingPoint.value
    let maxFirstIonizationEnergy = realmResult.sorted(byKeyPath: "ionizationEnergy").last?.ionizationEnergy.value
    
//    for item in maxDensity {
//      print("element no \(item.atomicNumber): \(item.density.value ?? 0)")
//    }
    
    for index in 0..<118 {
      let element = realmResult[index]
      let densityFraction = (element.density.value ?? 0) / maxDensity!
      let atomicRadiusFracion = (element.calculatedRadius.value ?? 0) / maxAtomicRadius!
      let electronegativityFraction = (element.electronegativity.value ?? 0) / maxElectronegativity!
      let meltingPointFraction = (element.meltingPoint.value ?? 0) / maxMeltingPoint!
      let boilingPointFraction = (element.boilingPoint.value ?? 0) / maxBoilingPoint!
      let ionizationEnergyFraction = (element.ionizationEnergy.value ?? 0) / maxFirstIonizationEnergy!
//      print("element no \(element.atomicNumber): \(densityFraction) .. max: \(maxDensity!)")
      do {
        try realm.write {
          element.densityComparationFraction = densityFraction * 100
          element.atomicRadiusComparationFraction = atomicRadiusFracion * 100
          element.electronegativityComparationFraction = electronegativityFraction * 100
          element.meltingPointComparationFraction = meltingPointFraction * 100
          element.boilingPointComparationFraction = boilingPointFraction * 100
          element.ionizationEnergyComparationFraction = ionizationEnergyFraction * 100
        }
      } catch {
        print("Can't write to Realm with error : \(error)")
      }

    }
    
    
  }
}
