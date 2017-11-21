//
//  MoreDetailViewController.swift
//  prototype1
//
//  Created by Swift Mage on 08/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import SwiftyJSON

class MoreDetailViewController: UITableViewController {

  
  private let propertiesNameDictionary: [Element_.Properties: [Element_.MoreProperties]] = [
    Element_.Properties.hardness: [Element_.MoreProperties.vickers,
                          Element_.MoreProperties.mohs,
                          Element_.MoreProperties.brinell],
    Element_.Properties.atomicRadius: [Element_.MoreProperties.covalentRadius,
                              Element_.MoreProperties.empiricalRadius,
                              Element_.MoreProperties.vanDerWaalsRadius,
                              Element_.MoreProperties.calculatedRadius,
                              Element_.MoreProperties.ionRadius],
    Element_.Properties.modulus: [Element_.MoreProperties.youngModulus,
                         Element_.MoreProperties.shearModulus,
                         Element_.MoreProperties.bulkModulus],
    Element_.Properties.conductivity: [Element_.MoreProperties.electricalConductivity,
                              Element_.MoreProperties.thermalConductivity],
    Element_.Properties.heat: [Element_.MoreProperties.specificHeat,
                      Element_.MoreProperties.vaporHeat,
                      Element_.MoreProperties.fusionHeat],
    Element_.Properties.abundance: [Element_.MoreProperties.universeAbundance,
                           Element_.MoreProperties.solarAbundance,
                           Element_.MoreProperties.meteorAbundance,
                           Element_.MoreProperties.crustAbundance,
                           Element_.MoreProperties.oceanAbundance,
                           Element_.MoreProperties.humanAbundance]]
  
  
  var property: Element_.Properties! {
    didSet {
      self.title = property.name
    }
  }
  
  var theElement: Element_!
  private lazy var properties = { () -> [Element_.MoreProperties] in
    return propertiesNameDictionary[property]!
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return properties.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let property = properties[indexPath.row]
      let value = valueForProperty(property)
      let unit = property.unit

      return makeAPropertyCell(indexPath: indexPath, for: property, with: value, unit: unit)
  }
}


// MARK: - Extension Helper Methods
extension MoreDetailViewController {
  private func modifyUnknownCell(cell: UITableViewCell) {
    cell.detailTextLabel?.text = UnknownValue.string
    cell.detailTextLabel?.textColor = UIColor.gray
  }
  
  private func makeAPropertyCell(indexPath: IndexPath, for property: Element_.MoreProperties, with value: String, unit: Unit.RawValue) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = property.name
    cell.textLabel?.textColor = UIColor.gray
    cell.detailTextLabel?.numberOfLines = 0
    if value == UnknownValue.string {
      cell.detailTextLabel?.text = UnknownValue.string
      cell.detailTextLabel?.textColor = UIColor.gray
    } else {
      cell.detailTextLabel?.text = "\(value) \(unit)"
    }
    return cell
  }
  
  private func valueForProperty(_ moreProperty: Element_.MoreProperties) -> String {
    guard let element = theElement else { return "" }
    
    func abundancePercentage(_ value: Double?) -> String {
      guard var value = value else { return UnknownValue.string }
      value *= 100
      return value.decimalFormatted
    }
    
    func ionRadiusToString(_ dict: [String:Double]?) -> String {
      guard let dict = dict else { return UnknownValue.string }
      var stringText = String()
      for (key, item) in dict {
        let ionName = key
        let radius  = item
        stringText = "((\(ionName)) : \(radius))" // NO DATA SHOWS IT HAS MORE THAN ONE, needs to be changed if in the future there is
      }
      if stringText.isEmpty {
        return UnknownValue.string
      } else {
        return stringText
      }
    }
    
    func makeAStringFrom(_ value: Double?) -> String {
      guard let value = value else { return UnknownValue.string }
      return String(value)
    }
    
    let dictionary: [Element_.MoreProperties: String] = [Element_.MoreProperties.vickers: makeAStringFrom(element.hardness.vickers),
      Element_.MoreProperties.mohs: makeAStringFrom(element.hardness.mohs),
      Element_.MoreProperties.brinell: makeAStringFrom(element.hardness.brinell),
      Element_.MoreProperties.covalentRadius: makeAStringFrom(element.atomicRadius.covalent),
      Element_.MoreProperties.empiricalRadius: makeAStringFrom(element.atomicRadius.empirical),
      Element_.MoreProperties.vanDerWaalsRadius: makeAStringFrom(element.atomicRadius.vanDerWaals),
      Element_.MoreProperties.calculatedRadius: makeAStringFrom(element.atomicRadius.calculated),
      Element_.MoreProperties.ionRadius: ionRadiusToString(element.atomicRadius.ion),
      Element_.MoreProperties.youngModulus: makeAStringFrom(element.modulus.young),
      Element_.MoreProperties.shearModulus: makeAStringFrom(element.modulus.shear),
      Element_.MoreProperties.bulkModulus: makeAStringFrom(element.modulus.bulk),
      Element_.MoreProperties.electricalConductivity: makeAStringFrom(element.conductivity.electric),
      Element_.MoreProperties.thermalConductivity: makeAStringFrom(element.conductivity.thermal),
      Element_.MoreProperties.specificHeat: makeAStringFrom(element.heatProperties.specificHeat),
      Element_.MoreProperties.vaporHeat: makeAStringFrom(element.heatProperties.vaporizationHeat),
      Element_.MoreProperties.fusionHeat: makeAStringFrom(element.heatProperties.fusionHeat),
      Element_.MoreProperties.universeAbundance: abundancePercentage(element.abundance.inUniverse),
      Element_.MoreProperties.solarAbundance: abundancePercentage(element.abundance.inUniverse),
      Element_.MoreProperties.meteorAbundance: abundancePercentage(element.abundance.inMeteor),
      Element_.MoreProperties.crustAbundance: abundancePercentage(element.abundance.inCrust),
      Element_.MoreProperties.oceanAbundance: abundancePercentage(element.abundance.inOcean),
      Element_.MoreProperties.humanAbundance: abundancePercentage(element.abundance.inHuman)]
    
    return dictionary[moreProperty]!
  }
  
  
}

