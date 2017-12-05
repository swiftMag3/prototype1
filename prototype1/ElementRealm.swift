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
  @objc dynamic var ion = ""
  @objc dynamic var radius = 0.0
}

class ELementRealm: Object {
  
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
  
  override static func primaryKey() -> String? {
    return "atomicNumber"
  }
}
