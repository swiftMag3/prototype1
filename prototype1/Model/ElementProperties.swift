//
//  ElementProperties.swift
//  prototype1
//
//  Created by Swift Mage on 26/10/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation

// MARK: - DICTIONARIES
internal let nameForElement = ["Hydrogen": NSLocalizedString("Hydrogen", comment: "Localized name: Hydrogen"), "Helium": NSLocalizedString("Helium", comment: "Localized name: Helium"), "Lithium": NSLocalizedString("Lithium", comment: "Localized name: Lithium"), "Beryllium": NSLocalizedString("Beryllium", comment: "Localized name: Beryllium"), "Boron": NSLocalizedString("Boron", comment: "Localized name: Boron"), "Carbon": NSLocalizedString("Carbon", comment: "Localized name: Carbon"), "Nitrogen": NSLocalizedString("Nitrogen", comment: "Localized name: Nitrogen"), "Oxygen": NSLocalizedString("Oxygen", comment: "Localized name: Oxygen"), "Fluorine": NSLocalizedString("Fluorine", comment: "Localized name: Fluorine"), "Neon": NSLocalizedString("Neon", comment: "Localized name: Neon"), "Sodium": NSLocalizedString("Sodium", comment: "Localized name: Sodium"), "Magnesium": NSLocalizedString("Magnesium", comment: "Localized name: Magnesium"), "Aluminum": NSLocalizedString("Aluminum", comment: "Localized name: Aluminum"), "Silicon": NSLocalizedString("Silicon", comment: "Localized name: Silicon"), "Phosphorus": NSLocalizedString("Phosphorus", comment: "Localized name: Phosphorus"), "Sulfur": NSLocalizedString("Sulfur", comment: "Localized name: Sulfur"), "Chlorine": NSLocalizedString("Chlorine", comment: "Localized name: Chlorine"), "Argon": NSLocalizedString("Argon", comment: "Localized name: Argon"), "Potassium": NSLocalizedString("Potassium", comment: "Localized name: Potassium"), "Calcium": NSLocalizedString("Calcium", comment: "Localized name: Calcium"), "Scandium": NSLocalizedString("Scandium", comment: "Localized name: Scandium"), "Titanium": NSLocalizedString("Titanium", comment: "Localized name: Titanium"), "Vanadium": NSLocalizedString("Vanadium", comment: "Localized name: Vanadium"), "Chromium": NSLocalizedString("Chromium", comment: "Localized name: Chromium"), "Manganese": NSLocalizedString("Manganese", comment: "Localized name: Manganese"), "Iron": NSLocalizedString("Iron", comment: "Localized name: Iron"), "Cobalt": NSLocalizedString("Cobalt", comment: "Localized name: Cobalt"), "Nickel": NSLocalizedString("Nickel", comment: "Localized name: Nickel"), "Copper": NSLocalizedString("Copper", comment: "Localized name: Copper"), "Zinc": NSLocalizedString("Zinc", comment: "Localized name: Zinc"), "Gallium": NSLocalizedString("Gallium", comment: "Localized name: Gallium"), "Germanium": NSLocalizedString("Germanium", comment: "Localized name: Germanium"), "Arsenic": NSLocalizedString("Arsenic", comment: "Localized name: Arsenic"), "Selenium": NSLocalizedString("Selenium", comment: "Localized name: Selenium"), "Bromine": NSLocalizedString("Bromine", comment: "Localized name: Bromine"), "Krypton": NSLocalizedString("Krypton", comment: "Localized name: Krypton"), "Rubidium": NSLocalizedString("Rubidium", comment: "Localized name: Rubidium"), "Strontium": NSLocalizedString("Strontium", comment: "Localized name: Strontium"), "Yttrium": NSLocalizedString("Yttrium", comment: "Localized name: Yttrium"), "Zirconium": NSLocalizedString("Zirconium", comment: "Localized name: Zirconium"), "Niobium": NSLocalizedString("Niobium", comment: "Localized name: Niobium"), "Molybdenum": NSLocalizedString("Molybdenum", comment: "Localized name: Molybdenum"), "Technetium": NSLocalizedString("Technetium", comment: "Localized name: Technetium"), "Ruthenium": NSLocalizedString("Ruthenium", comment: "Localized name: Ruthenium"), "Rhodium": NSLocalizedString("Rhodium", comment: "Localized name: Rhodium"), "Palladium": NSLocalizedString("Palladium", comment: "Localized name: Palladium"), "Silver": NSLocalizedString("Silver", comment: "Localized name: Silver"), "Cadmium": NSLocalizedString("Cadmium", comment: "Localized name: Cadmium"), "Indium": NSLocalizedString("Indium", comment: "Localized name: Indium"), "Tin": NSLocalizedString("Tin", comment: "Localized name: Tin"), "Antimony": NSLocalizedString("Antimony", comment: "Localized name: Antimony"), "Tellurium": NSLocalizedString("Tellurium", comment: "Localized name: Tellurium"), "Iodine": NSLocalizedString("Iodine", comment: "Localized name: Iodine"), "Xenon": NSLocalizedString("Xenon", comment: "Localized name: Xenon"), "Cesium": NSLocalizedString("Cesium", comment: "Localized name: Cesium"), "Barium": NSLocalizedString("Barium", comment: "Localized name: Barium"), "Lanthanum": NSLocalizedString("Lanthanum", comment: "Localized name: Lanthanum"), "Cerium": NSLocalizedString("Cerium", comment: "Localized name: Cerium"), "Praseodymium": NSLocalizedString("Praseodymium", comment: "Localized name: Praseodymium"), "Neodymium": NSLocalizedString("Neodymium", comment: "Localized name: Neodymium"), "Promethium": NSLocalizedString("Promethium", comment: "Localized name: Promethium"), "Samarium": NSLocalizedString("Samarium", comment: "Localized name: Samarium"), "Europium": NSLocalizedString("Europium", comment: "Localized name: Europium"), "Gadolinium": NSLocalizedString("Gadolinium", comment: "Localized name: Gadolinium"), "Terbium": NSLocalizedString("Terbium", comment: "Localized name: Terbium"), "Dysprosium": NSLocalizedString("Dysprosium", comment: "Localized name: Dysprosium"), "Holmium": NSLocalizedString("Holmium", comment: "Localized name: Holmium"), "Erbium": NSLocalizedString("Erbium", comment: "Localized name: Erbium"), "Thulium": NSLocalizedString("Thulium", comment: "Localized name: Thulium"), "Ytterbium": NSLocalizedString("Ytterbium", comment: "Localized name: Ytterbium"), "Lutetium": NSLocalizedString("Lutetium", comment: "Localized name: Lutetium"), "Hafnium": NSLocalizedString("Hafnium", comment: "Localized name: Hafnium"), "Tantalum": NSLocalizedString("Tantalum", comment: "Localized name: Tantalum"), "Tungsten": NSLocalizedString("Tungsten", comment: "Localized name: Tungsten"), "Rhenium": NSLocalizedString("Rhenium", comment: "Localized name: Rhenium"), "Osmium": NSLocalizedString("Osmium", comment: "Localized name: Osmium"), "Iridium": NSLocalizedString("Iridium", comment: "Localized name: Iridium"), "Platinum": NSLocalizedString("Platinum", comment: "Localized name: Platinum"), "Gold": NSLocalizedString("Gold", comment: "Localized name: Gold"), "Mercury": NSLocalizedString("Mercury", comment: "Localized name: Mercury"), "Thallium": NSLocalizedString("Thallium", comment: "Localized name: Thallium"), "Lead": NSLocalizedString("Lead", comment: "Localized name: Lead"), "Bismuth": NSLocalizedString("Bismuth", comment: "Localized name: Bismuth"), "Polonium": NSLocalizedString("Polonium", comment: "Localized name: Polonium"), "Astatine": NSLocalizedString("Astatine", comment: "Localized name: Astatine"), "Radon": NSLocalizedString("Radon", comment: "Localized name: Radon"), "Francium": NSLocalizedString("Francium", comment: "Localized name: Francium"), "Radium": NSLocalizedString("Radium", comment: "Localized name: Radium"), "Actinium": NSLocalizedString("Actinium", comment: "Localized name: Actinium"), "Thorium": NSLocalizedString("Thorium", comment: "Localized name: Thorium"), "Protactinium": NSLocalizedString("Protactinium", comment: "Localized name: Protactinium"), "Uranium": NSLocalizedString("Uranium", comment: "Localized name: Uranium"), "Neptunium": NSLocalizedString("Neptunium", comment: "Localized name: Neptunium"), "Plutonium": NSLocalizedString("Plutonium", comment: "Localized name: Plutonium"), "Americium": NSLocalizedString("Americium", comment: "Localized name: Americium"), "Curium": NSLocalizedString("Curium", comment: "Localized name: Curium"), "Berkelium": NSLocalizedString("Berkelium", comment: "Localized name: Berkelium"), "Californium": NSLocalizedString("Californium", comment: "Localized name: Californium"), "Einsteinium": NSLocalizedString("Einsteinium", comment: "Localized name: Einsteinium"), "Fermium": NSLocalizedString("Fermium", comment: "Localized name: Fermium"), "Mendelevium": NSLocalizedString("Mendelevium", comment: "Localized name: Mendelevium"), "Nobelium": NSLocalizedString("Nobelium", comment: "Localized name: Nobelium"), "Lawrencium": NSLocalizedString("Lawrencium", comment: "Localized name: Lawrencium"), "Rutherfordium": NSLocalizedString("Rutherfordium", comment: "Localized name: Rutherfordium"), "Dubnium": NSLocalizedString("Dubnium", comment: "Localized name: Dubnium"), "Seaborgium": NSLocalizedString("Seaborgium", comment: "Localized name: Seaborgium"), "Bohrium": NSLocalizedString("Bohrium", comment: "Localized name: Bohrium"), "Hassium": NSLocalizedString("Hassium", comment: "Localized name: Hassium"), "Meitnerium": NSLocalizedString("Meitnerium", comment: "Localized name: Meitnerium"), "Darmstadtium": NSLocalizedString("Darmstadtium", comment: "Localized name: Darmstadtium"), "Roentgenium": NSLocalizedString("Roentgenium", comment: "Localized name: Roentgenium"), "Copernicium": NSLocalizedString("Copernicium", comment: "Localized name: Copernicium"), "Nihonium": NSLocalizedString("Nihonium", comment: "Localized name: Nihonium"), "Flerovium": NSLocalizedString("Flerovium", comment: "Localized name: Flerovium"), "Moscovium": NSLocalizedString("Moscovium", comment: "Localized name: Moscovium"), "Livermorium": NSLocalizedString("Livermorium", comment: "Localized name: Livermorium"), "Tennessine": NSLocalizedString("Tennessine", comment: "Localized name: Tennessine"), "Oganesson": NSLocalizedString("Oganesson", comment: "Localized name: Oganesson")]

internal let groupForElement = ["nonmetal": NSLocalizedString("nonmetal", comment: "Localized name: nonmetal"), "noble gas": NSLocalizedString("noble gas", comment: "Localized name: noble gas"), "alkali metal": NSLocalizedString("alkali metal", comment: "Localized name: alkali metal"), "alkaline earth metal": NSLocalizedString("alkaline earth metal", comment: "Localized name: alkaline earth metal"), "metalloid": NSLocalizedString("metalloid", comment: "Localized name: metalloid"), "metal": NSLocalizedString("metal", comment: "Localized name: metal"), "transition metal": NSLocalizedString("transition metal", comment: "Localized name: transition metal"), "halogen": NSLocalizedString("halogen", comment: "Localized name: halogen"), "lanthanoid": NSLocalizedString("lanthanoid", comment: "Localized name: lanthanoid"), "actinoid": NSLocalizedString("actinoid", comment: "Localized name: actinoid"), "post-transition metal": NSLocalizedString("post-transition metal", comment: "Localized name: post-transition metal")]

internal let iupacForElement = ["nonmetal": NSLocalizedString("nonmetal", comment: "Localized name: nonmetal"), "noble gas": NSLocalizedString("noble gas", comment: "Localized name: noble gas"), "alkali metal": NSLocalizedString("alkali metal", comment: "Localized name: alkali metal"), "alkaline earth metal": NSLocalizedString("alkaline earth metal", comment: "Localized name: alkaline earth metal"), "boron": NSLocalizedString("boron", comment: "Localized name: boron"), "carbon": NSLocalizedString("carbon", comment: "Localized name: carbon"), "pnictogen": NSLocalizedString("pnictogen", comment: "Localized name: pnictogen"), "chalcogen": NSLocalizedString("chalcogen", comment: "Localized name: chalcogen"), "halogen": NSLocalizedString("halogen", comment: "Localized name: halogen"), "transition metal": NSLocalizedString("transition metal", comment: "Localized name: transition metal"), "lanthanoid": NSLocalizedString("lanthanoid", comment: "Localized name: lanthanoid"), "actinoid": NSLocalizedString("actinoid", comment: "Localized name: actinoid"), "Unknown": NSLocalizedString("Unknown", comment: "Localized name: Unknown")]

internal let stateForElement = ["gas": NSLocalizedString("gas", comment: "Localized name: gas"), "solid": NSLocalizedString("solid", comment: "Localized name: solid"), "liquid": NSLocalizedString("liquid", comment: "Localized name: liquid"),]

internal let bondingTypeForElement = ["diatomic": NSLocalizedString("diatomic", comment: "Localized name: diatomic"), "atomic": NSLocalizedString("atomic", comment: "Localized name: atomic"), "metallic": NSLocalizedString("metallic", comment: "Localized name: metallic"), "covalent network": NSLocalizedString("covalent network", comment: "Localized name: covalent network"), "Unknown": NSLocalizedString("Unknown", comment: "Localized name: Unknown"),]

struct UnknownValue {
  static var string: String {
    return "Unknown".localize(withComment: "Unknown property value")
  }
}

// MARK: - STRUCTS


struct ElementID {
  let atomicNumber: Int
  let symbol: String
  let name: String
  let cpkHexColor: String?
  let iupacBlock: String?
  let legacyBlock: String
  let yearDiscovered: String
  let elementPosition: TableLocation
  
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
    let iupac = self.iupacBlock ?? "Unknown".localize(withComment: "Unknown Value")
    return iupacForElement[iupac] ?? "Unknown".localize(withComment: "Unknown Value")
  }
}

struct TableLocation: CustomStringConvertible {
  let row: Int
  let column: Int
  
  var description: String {
    return "(\(row), \(column))"
  }

  
}

// Basic Properties
struct BasicProperties {
  let atomicMass: Double
  let standardState: String
  let density: Double?
  let electronicConfiguration: String
  let valence: Int
  let meltingPoint: Double?
  let boilingPoint: Double?
  let bondingType: String?
  
  /// Localized version of standard state
  var localizedState: String {
    let state = self.standardState
    return stateForElement[state] ?? state
  }
  
  /// Localized version of bonding type
  var localizedBondingType: String {
    let bondingType = self.bondingType ?? "Unknown".localize(withComment: "Unknown Value")
    return bondingTypeForElement[bondingType] ?? "Unknown".localize(withComment: "Unknown Value")
  }
}


// Advanced Properties
struct AdvancedProperties {
  let electronegativity: Double?
  let electronAffinity: Double?
  let ionizationEnergy: Double?
  let oxidationStates: String?
  let atomicRadius: AtomicRadius
  let hardness: Hardness
  let modulus: Modulus
  let conductivity: Conductivity
  let heatProperties: HeatProperties
  let abundace: Abundance
}

// Atomic Radius
struct AtomicRadius {
  let vanDerWaals: Double?
  let empirical: Double?
  let calculated: Double?
  let covalent: Double?
  let ion: [String: Double]?
}

// Hardness
struct Hardness {
  let vickers: Double?
  let mohs: Double?
  let brinell: Double?
}

// Modulus
struct Modulus {
  let young: Double?
  let shear: Double?
  let bulk: Double?
  
}

// Conductivity
struct Conductivity {
  let electric: Double?
  let thermal: Double?
}

// Heat
struct HeatProperties {
  let specificHeat: Double?
  let vaporizationHeat: Double?
  let fusionHeat: Double?
}

// Abundance
struct Abundance {
  let inUniverse: Double?
  let inSolar: Double?
  let inMeteor: Double?
  let inCrust: Double?
  let inOcean: Double?
  let inHuman: Double?
}
