//
//  Element.swift
//  prototype1
//
//  Created by Swift Mage on 14/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

enum Unit: String {
  case density = "kg/m{3}"
  case energy = "kJ/mol"
  case temperature = "K"
  case hardness = "MPa"
  case radius = "pm"
  case modulus = "GPa"
  case conductivity = "W/m.K"
  case heatEnergy = "J/kg.K"
  case percentage = "%"
}

//class Element_  {
//  var atomicNumber: Int
//  var symbol: String
//  var name: String
//  var cpkHexColor: String
//  var iupacBlock: String
//  var legacyBlock: String
//  var yearDiscovered: String
//  var elementPosition: TableLocation
//  var atomicMass: Double
//  var standardState: String
//  var density: Double?
//  var electronicConfiguration: String
//  var valence: Int
//  var meltingPoint: Double?
//  var boilingPoint: Double?
//  var bondingType: String
//  var electronegativity: Double?
//  var electronAffinity: Double?
//  var ionizationEnergy: Double?
//  var oxidationStates: String
//  var atomicRadius: AtomicRadius
//  var hardness: Hardness
//  var modulus: Modulus
//  var conductivity: Conductivity
//  var heatProperties: HeatProperties
//  var abundance: Abundance
//
//  init() {
//    self.atomicNumber = 0
//    self.symbol = "XX"
//    self.name = UnknownValue.string
//    self.cpkHexColor = UnknownValue.string
//    self.iupacBlock = UnknownValue.string
//    self.legacyBlock = UnknownValue.string
//    self.yearDiscovered = UnknownValue.string
//    self.elementPosition = TableLocation(row: 0, column: 0)
//    self.atomicMass = 0.0
//    self.standardState = UnknownValue.string
//    self.density = nil
//    self.electronicConfiguration = UnknownValue.string
//    self.valence = 0
//    self.meltingPoint = nil
//    self.boilingPoint = nil
//    self.bondingType = UnknownValue.string
//    self.electronegativity = nil
//    self.electronAffinity = nil
//    self.ionizationEnergy = nil
//    self.oxidationStates = UnknownValue.string
//    self.atomicRadius = AtomicRadius(vanDerWaals: nil, empirical: nil, calculated: nil, covalent: nil, ion: nil)
//    self.hardness = Hardness(vickers: nil, mohs: nil, brinell: nil)
//    self.modulus = Modulus(young: nil, shear: nil, bulk: nil)
//    self.conductivity = Conductivity(electric: nil, thermal: nil)
//    self.heatProperties = HeatProperties(specificHeat: nil, vaporizationHeat: nil, fusionHeat: nil)
//    self.abundance = Abundance(inUniverse: nil, inSolar: nil, inMeteor: nil, inCrust: nil, inOcean: nil, inHuman: nil)
//  }
//
//  init(atomicNumber: Int,
//       symbol: String,
//       name: String,
//       cpkHexColor: String,
//       iupacBlock: String,
//       legacyBlock: String,
//       yearDiscovered: String,
//       elementPosition: TableLocation,
//       atomicMass: Double,
//       standardState: String,
//       density: Double?,
//       electronicConfiguration: String,
//       valence: Int,
//       meltingPoint: Double?,
//       boilingPoint: Double?,
//       bondingType: String,
//       electronegativity: Double?,
//       electronAffinity: Double?,
//       ionizationEnergy: Double?,
//       oxidationStates: String,
//       atomicRadius: AtomicRadius,
//       hardness: Hardness,
//       modulus: Modulus,
//       conductivity: Conductivity,
//       heatProperties: HeatProperties,
//       abundance: Abundance) {
//    self.atomicNumber = atomicNumber
//    self.symbol = symbol
//    self.name = name
//    self.cpkHexColor = cpkHexColor
//    self.iupacBlock = iupacBlock
//    self.legacyBlock = legacyBlock
//    self.yearDiscovered = yearDiscovered
//    self.elementPosition = elementPosition
//    self.atomicMass = atomicMass
//    self.standardState = standardState
//    self.density = density
//    self.electronicConfiguration = electronicConfiguration
//    self.valence = valence
//    self.meltingPoint = meltingPoint
//    self.boilingPoint = boilingPoint
//    self.bondingType = bondingType
//    self.electronegativity = electronegativity
//    self.electronAffinity = electronAffinity
//    self.ionizationEnergy = ionizationEnergy
//    self.oxidationStates = oxidationStates
//    self.atomicRadius = atomicRadius
//    self.hardness = hardness
//    self.modulus = modulus
//    self.conductivity = conductivity
//    self.heatProperties = heatProperties
//    self.abundance = abundance
//  }
//
//  /// Localized version of name properties
//  var localizedName: String {
//    let name = self.name
//    return nameForElement[name] ?? name
//  }
//
//  /// Localized version of group
//  var localizedGroup: String {
//    let group = self.legacyBlock
//    return groupForElement[group] ?? group
//  }
//
//  /// Localized version of iupac name
//  var localizedIUPAC: String {
//    let iupac = self.iupacBlock
//    return iupacForElement[iupac] ?? UnknownValue.string
//  }
//
//  /// Localized version of standard state
//  var localizedState: String {
//    let state = self.standardState
//    return stateForElement[state] ?? state
//  }
//
//  /// Localized version of bonding type
//  var localizedBondingType: String {
//    let bondingType = self.bondingType
//    return bondingTypeForElement[bondingType] ?? UnknownValue.string
//  }
//}

// MARK: - Extension for Properties
extension ElementRealm: Any {
  enum Properties {
    case symbol
    case atomicNumber
    case groupPeriod
    case atomicMass
    case standardState
    case elementCategory
    case yearDiscovered
    case electronConfiguration
    case valence
    case electronegativity
    case electronAffinity
    case ionizationEnergy
    case oxidationState
    case bondingType
    case meltingPoint
    case boilingPoint
    case atomicRadius
    case hardness
    case modulus
    case density
    case conductivity
    case heat
    case abundance
    
    var name: String {
      switch self {
      case .symbol:
        return "Symbol".localize(withComment: "detailView properties")
      case .atomicNumber:
        return "Atomic Number".localize(withComment: "detailView properties")
      case .groupPeriod:
        return "Period, Group".localize(withComment: "detailView properties")
      case .atomicMass:
        return "Atomic Mass".localize(withComment: "detailView properties")
      case .standardState:
        return   "Standard State ( at 273 K)".localize(withComment: "detailView properties")
      case .elementCategory:
        return "Element Category".localize(withComment: "detailView properties")
      case .yearDiscovered:
        return "Year Discovered".localize(withComment: "detailView properties")
      case .electronConfiguration:
        return "Electron Configuration".localize(withComment: "detailView properties")
      case .valence:
        return "Valence".localize(withComment: "detailView properties")
      case .electronegativity:
        return "Electronegativity".localize(withComment: "detailView properties")
      case .electronAffinity:
        return "Electron Affinity".localize(withComment: "detailView properties")
      case .ionizationEnergy:
        return "Ionization Energy".localize(withComment: "detailView properties")
      case .oxidationState:
        return "Oxidation State".localize(withComment: "detailView properties")
      case .bondingType:
        return "Bonding Type".localize(withComment: "detailView properties")
      case .meltingPoint:
        return "Melting Point".localize(withComment: "detailView properties")
      case .boilingPoint:
        return "Boiling Point".localize(withComment: "detailView properties")
      case .atomicRadius:
        return "Atomic Radius".localize(withComment: "detailView properties")
      case .hardness:
        return "Hardness".localize(withComment: "detailView properties")
      case .modulus:
        return "Modulus".localize(withComment: "detailView properties")
      case .density:
        return "Density (STP)".localize(withComment: "detailView properties")
      case .conductivity:
        return "Conductivity".localize(withComment: "detailView properties")
      case .heat:
        return "Heat".localize(withComment: "detailView properties")
      case .abundance:
        return "Abundance (by mass)".localize(withComment: "detailView properties")
      }
    }
    
    var unit: String? {
      switch self {
      case .symbol, .atomicNumber, .groupPeriod, .atomicMass, .standardState, .elementCategory, .yearDiscovered, .electronConfiguration, .valence, .electronegativity, .oxidationState, .bondingType, .atomicRadius, .hardness, .modulus, .conductivity, .heat, .abundance:
        return nil
      case .density:
        return Unit.density.rawValue
      case .electronAffinity, .ionizationEnergy:
        return Unit.energy.rawValue
      case .meltingPoint, .boilingPoint:
        return Unit.temperature.rawValue
      }
    }
  }
  
  enum MoreProperties: String {
    case vickers
    case mohs
    case brinell
    case covalentRadius
    case empiricalRadius
    case vanDerWaalsRadius
    case calculatedRadius
    case ionRadius
    case youngModulus
    case shearModulus
    case bulkModulus
    case electricalConductivity
    case thermalConductivity
    case specificHeat
    case vaporHeat
    case fusionHeat
    case universeAbundance
    case solarAbundance
    case meteorAbundance
    case crustAbundance
    case oceanAbundance
    case humanAbundance
    
    var name: String {
      switch self {
      case .vickers:
        return "Vickers".localize(withComment: "MoreDetail Properties")
      case .mohs:
        return "Mohs".localize(withComment: "MoreDetail Properties")
      case .brinell:
        return "Brinell".localize(withComment: "MoreDetail Properties")
      case .covalentRadius:
        return "Covalent Radius".localize(withComment: "MoreDetail Properties")
      case .empiricalRadius:
        return "Empirical".localize(withComment: "MoreDetail Properties")
      case .vanDerWaalsRadius:
        return "Van der Waals Radius".localize(withComment: "MoreDetail Properties")
      case .calculatedRadius:
        return "Calculated Radius".localize(withComment: "MoreDetail Properties")
      case .ionRadius:
        return "Ion Radius".localize(withComment: "MoreDetail Properties")
      case .youngModulus:
        return "Young Modulus".localize(withComment: "MoreDetail Properties")
      case .shearModulus:
        return "Shear Modulus".localize(withComment: "MoreDetail Properties")
      case .bulkModulus:
        return "Bulk Modulus".localize(withComment: "MoreDetail Properties")
      case .electricalConductivity:
        return "Electrical Conductivity".localize(withComment: "MoreDetail Properties")
      case .thermalConductivity:
        return "Thermal Conductivity".localize(withComment: "MoreDetail Properties")
      case .specificHeat:
        return "Specific Heat".localize(withComment: "MoreDetail Properties")
      case .vaporHeat:
        return "Vapor Heat".localize(withComment: "MoreDetail Properties")
      case .fusionHeat:
        return "Fusion Heat".localize(withComment: "MoreDetail Properties")
      case .universeAbundance:
        return "Universe".localize(withComment: "Abundance Context")
      case .solarAbundance:
        return "Solar".localize(withComment: "Abundance Context")
      case .meteorAbundance:
        return "Meteor".localize(withComment: "Abundance Context")
      case .crustAbundance:
        return "Earth Crust".localize(withComment: "Abundance Context")
      case .oceanAbundance:
        return "Ocean".localize(withComment: "Abundance Context")
      case .humanAbundance:
        return "Human".localize(withComment: "Abundance Context")
      }
    }
    var unit: String {
      switch self {
      case .vickers, .mohs, .brinell:
        return Unit.hardness.rawValue
      case .covalentRadius, .empiricalRadius, .vanDerWaalsRadius, .calculatedRadius, .ionRadius:
        return Unit.radius.rawValue
      case .bulkModulus, .shearModulus, .youngModulus:
        return Unit.modulus.rawValue
      case .thermalConductivity, .electricalConductivity:
        return Unit.conductivity.rawValue
      case .specificHeat, .vaporHeat, .fusionHeat:
        return Unit.heatEnergy.rawValue
      case .universeAbundance, .solarAbundance, .meteorAbundance, .crustAbundance, .oceanAbundance, .humanAbundance:
        return Unit.percentage.rawValue
      }
    }
  }
}


//// MARK: - Element_ extension EQUATABLE Protocol
//extension Element_: Equatable {
//  static func ==(lhs: Element_, rhs: Element_) -> Bool {
//    return lhs.atomicMass == rhs.atomicMass
//  }
//}

