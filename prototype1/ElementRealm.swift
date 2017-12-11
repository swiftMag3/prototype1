//
//  ElementRealm.swift
//  prototype1
//
//  Created by Swift Mage on 05/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation
import RealmSwift

class IonRadius: Object {
  
  convenience init(ion: String, radius: Double) {
    self.init()
    self.ion = ion
    self.radius = radius
  }
  
  @objc dynamic var ion = ""
  @objc dynamic var radius = 0.0
}

class ElementRealm: Object {
  
  @objc dynamic var atomicNumber = 0
  @objc dynamic var symbol = ""
  @objc dynamic var name = ""
  @objc dynamic var cpkHexColor = ""
  @objc dynamic var iupacBlock = ""
  @objc dynamic var legacyBlock = ""
  @objc dynamic var yearDiscovered = ""
  @objc dynamic var elementRow = 0
  @objc dynamic var elementColumn = 0
  @objc dynamic var atomicMass = 0.0
  @objc dynamic var standardState = ""
  @objc dynamic var electronicConfiguration = ""
  @objc dynamic var valence = 0
  @objc dynamic var bondingType = ""
  @objc dynamic var oxidationStates = ""
  
  // Added properties
  @objc dynamic var isBookmarked = false
  @objc dynamic var densityComparationFraction: Double = 0
  @objc dynamic var atomicRadiusComparationFraction: Double = 0
  @objc dynamic var electronegativityComparationFraction: Double = 0
  @objc dynamic var meltingPointComparationFraction: Double = 0
  @objc dynamic var boilingPointComparationFraction: Double = 0
  @objc dynamic var ionizationEnergyComparationFraction: Double = 0.0
  
  
  let density = RealmOptional<Double>()
  let meltingPoint = RealmOptional<Double>()
  let boilingPoint = RealmOptional<Double>()
  let electronegativity = RealmOptional<Double>()
  let electronAffinity = RealmOptional<Double>()
  let ionizationEnergy = RealmOptional<Double>()
  let vanDerWaalsRadius = RealmOptional<Double>()
  let empiricalRadius = RealmOptional<Double>()
  let calculatedRadius = RealmOptional<Double>()
  let covalentRadius = RealmOptional<Double>()
  let ionRadius = List<IonRadius>()
  let vickersHardness = RealmOptional<Double>()
  let mohsHardness = RealmOptional<Double>()
  let brinellHardness = RealmOptional<Double>()
  let youngModulus = RealmOptional<Double>()
  let shearModulus = RealmOptional<Double>()
  let bulkModulus = RealmOptional<Double>()
  let electricalConductivity = RealmOptional<Double>()
  let thermalConductivity = RealmOptional<Double>()
  let specifictHeat = RealmOptional<Double>()
  let vaporizationHeat = RealmOptional<Double>()
  let fusionHeat = RealmOptional<Double>()
  let abundanceInUniverse = RealmOptional<Double>()
  let abundanceInSolar = RealmOptional<Double>()
  let abundanceInMeteor = RealmOptional<Double>()
  let abundanceInCrust = RealmOptional<Double>()
  let abundanceInOcean = RealmOptional<Double>()
  let abundaceInHuman = RealmOptional<Double>()
  
  /// Localized version of name properties
  var localizedName: String {
    let name = self.name
    return nameForElement[name] ?? name
  }
  
  /// Localized version of group
  var localizedGroup: String {
    let group = self.legacyBlock
    return groupForElement[group] ?? group
  }
  
  /// Localized version of iupac name
  var localizedIUPAC: String {
    let iupac = self.iupacBlock
    return iupacForElement[iupac] ?? UnknownValue.string
  }
  
  /// Localized version of standard state
  var localizedState: String {
    let state = self.standardState
    return stateForElement[state] ?? state
  }
  
  /// Localized version of bonding type
  var localizedBondingType: String {
    let bondingType = self.bondingType
    return bondingTypeForElement[bondingType] ?? UnknownValue.string
  }
  
  
  override static func primaryKey() -> String? {
    return "atomicNumber"
  }
}



