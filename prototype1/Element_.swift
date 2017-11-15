//
//  Element.swift
//  prototype1
//
//  Created by Swift Mage on 14/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

class Element_  {
  var atomicNumber: Int
  var symbol: String
  var name: String
  var cpkHexColor: String
  var iupacBlock: String
  var legacyBlock: String
  var yearDiscovered: String
  var elementPosition: TableLocation
  var atomicMass: Double
  var standardState: String
  var density: Double?
  var electronicConfiguration: String
  var valence: Int
  var meltingPoint: Double?
  var boilingPoint: Double?
  var bondingType: String
  var electronegativity: Double?
  var electronAffinity: Double?
  var ionizationEnergy: Double?
  var oxidationStates: String
  var atomicRadius: AtomicRadius
  var hardness: Hardness
  var modulus: Modulus
  var conductivity: Conductivity
  var heatProperties: HeatProperties
  var abundance: Abundance
  
  init() {
    self.atomicNumber = 0
    self.symbol = "XX"
    self.name = UnknownValue.string
    self.cpkHexColor = UnknownValue.string
    self.iupacBlock = UnknownValue.string
    self.legacyBlock = UnknownValue.string
    self.yearDiscovered = UnknownValue.string
    self.elementPosition = TableLocation(row: 0, column: 0)
    self.atomicMass = 0.0
    self.standardState = UnknownValue.string
    self.density = nil
    self.electronicConfiguration = UnknownValue.string
    self.valence = 0
    self.meltingPoint = nil
    self.boilingPoint = nil
    self.bondingType = UnknownValue.string
    self.electronegativity = nil
    self.electronAffinity = nil
    self.ionizationEnergy = nil
    self.oxidationStates = UnknownValue.string
    self.atomicRadius = AtomicRadius(vanDerWaals: nil, empirical: nil, calculated: nil, covalent: nil, ion: nil)
    self.hardness = Hardness(vickers: nil, mohs: nil, brinell: nil)
    self.modulus = Modulus(young: nil, shear: nil, bulk: nil)
    self.conductivity = Conductivity(electric: nil, thermal: nil)
    self.heatProperties = HeatProperties(specificHeat: nil, vaporizationHeat: nil, fusionHeat: nil)
    self.abundance = Abundance(inUniverse: nil, inSolar: nil, inMeteor: nil, inCrust: nil, inOcean: nil, inHuman: nil)
  }
  
  init(atomicNumber: Int,
       symbol: String,
       name: String,
       cpkHexColor: String,
       iupacBlock: String,
       legacyBlock: String,
       yearDiscovered: String,
       elementPosition: TableLocation,
       atomicMass: Double,
       standardState: String,
       density: Double?,
       electronicConfiguration: String,
       valence: Int,
       meltingPoint: Double?,
       boilingPoint: Double?,
       bondingType: String,
       electronegativity: Double?,
       electronAffinity: Double?,
       ionizationEnergy: Double?,
       oxidationStates: String,
       atomicRadius: AtomicRadius,
       hardness: Hardness,
       modulus: Modulus,
       conductivity: Conductivity,
       heatProperties: HeatProperties,
       abundance: Abundance) {
    self.atomicNumber = atomicNumber
    self.symbol = symbol
    self.name = name
    self.cpkHexColor = cpkHexColor
    self.iupacBlock = iupacBlock
    self.legacyBlock = legacyBlock
    self.yearDiscovered = yearDiscovered
    self.elementPosition = elementPosition
    self.atomicMass = atomicMass
    self.standardState = standardState
    self.density = density
    self.electronicConfiguration = electronicConfiguration
    self.valence = valence
    self.meltingPoint = meltingPoint
    self.boilingPoint = boilingPoint
    self.bondingType = bondingType
    self.electronegativity = electronegativity
    self.electronAffinity = electronAffinity
    self.ionizationEnergy = ionizationEnergy
    self.oxidationStates = oxidationStates
    self.atomicRadius = atomicRadius
    self.hardness = hardness
    self.modulus = modulus
    self.conductivity = conductivity
    self.heatProperties = heatProperties
    self.abundance = abundance
  }
  
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
}
