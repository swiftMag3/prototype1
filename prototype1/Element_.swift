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
  case radius = "pm\n"
  case modulus = "GPa"
  case conductivity = "W/m.K"
  case heatEnergy = "J/kg.K"
  case percentage = "%"
}

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


