//
//  ElementProperties.swift
//  prototype1
//
//  Created by Swift Mage on 26/10/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation

struct ElementID {
  let atomicNumber: Int
  let symbol: String
  let name: String
  let cpkHexColor: String?
  let iupacBlock: String?
  let legacyBlock: String
  let yearDiscovered: String
  let elementPosition: TableLocation
}

struct TableLocation {
  let row: Int
  let column: Int
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
