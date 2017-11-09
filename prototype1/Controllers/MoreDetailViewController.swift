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
  
  private let propertiesNameDictionary: [String: [String]] = [
    Properties.hardness: [MoreProperties.vickers,
                          MoreProperties.mohs,
                          MoreProperties.brinell],
    Properties.atomicRadius: [MoreProperties.covalentRadius,
                              MoreProperties.empiricalRadius,
                              MoreProperties.vanderWaalsRadius,
                              MoreProperties.calculatedRadius,
                              MoreProperties.ionRadius],
    Properties.modulus: [MoreProperties.youngModulus,
                         MoreProperties.shearModulus,
                         MoreProperties.bulkModulus],
    Properties.conductivity: [MoreProperties.electricalConductivity,
                              MoreProperties.thermalConductivity],
    Properties.heat: [MoreProperties.specificHeat,
                      MoreProperties.vaporHeat,
                      MoreProperties.fusionHeat],
    Properties.abundance: [MoreProperties.universeAbundance,
                           MoreProperties.solarAbundance,
                           MoreProperties.meteorAbundance,
                           MoreProperties.crustAbundance,
                           MoreProperties.oceanAbundance,
                           MoreProperties.humanAbundance]]
  //unfinished
  private let unitDictionary: [String: String] = [ MoreProperties.vickers: PropertiesUnit.hardness,
                                                   MoreProperties.mohs: PropertiesUnit.hardness,
                                                   MoreProperties.brinell: PropertiesUnit.hardness,
                                                   MoreProperties.covalentRadius: PropertiesUnit.radius,
                                                   MoreProperties.empiricalRadius: PropertiesUnit.radius,
                                                   MoreProperties.vanderWaalsRadius: PropertiesUnit.radius,
                                                   MoreProperties.calculatedRadius: PropertiesUnit.radius,
                                                   MoreProperties.ionRadius: PropertiesUnit.radius,
                                                   MoreProperties.youngModulus: PropertiesUnit.modulus,
                                                   MoreProperties.shearModulus: PropertiesUnit.modulus,
                                                   MoreProperties.bulkModulus: PropertiesUnit.modulus,
                                                   MoreProperties.electricalConductivity: PropertiesUnit.conductivity,
                                                   MoreProperties.thermalConductivity: PropertiesUnit.conductivity,
                                                   MoreProperties.specificHeat: PropertiesUnit.heat,
                                                   MoreProperties.vaporHeat: PropertiesUnit.heat,
                                                   MoreProperties.fusionHeat: PropertiesUnit.heat,
                                                   MoreProperties.universeAbundance: PropertiesUnit.abundance,
                                                   MoreProperties.solarAbundance: PropertiesUnit.abundance,
                                                   MoreProperties.meteorAbundance: PropertiesUnit.abundance,
                                                   MoreProperties.crustAbundance: PropertiesUnit.abundance,
                                                   MoreProperties.oceanAbundance: PropertiesUnit.abundance,
                                                   MoreProperties.humanAbundance: PropertiesUnit.abundance ]
  
  
  var propertiesValuesDictionary: [String: Any?] = [:]
  var propertyName: String!
  var element: Element!
  private lazy var properties: [String] = {
    return propertiesNameDictionary[propertyName]!
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = propertyName
    propertiesValuesDictionary = createPropertiesValueDictionary()
    
  }
    
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return properties.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let property = properties[indexPath.row]
      let value = propertiesValuesDictionary[property]!
      let unit = unitDictionary[property]

      return makeAPropertyCell(indexPath: indexPath, for: property, with: value, unit: unit)
//    }
  }
}


// MARK: - Extension Helper Methods
extension MoreDetailViewController {
  private func modifyUnknownCell(cell: UITableViewCell) {
    cell.detailTextLabel?.text = UnknownValue.string
    cell.detailTextLabel?.textColor = UIColor.gray
  }
  
  private func makeAPropertyCell(indexPath: IndexPath, for property: String, with value: Any?, unit: String?) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = property
    cell.textLabel?.textColor = UIColor.gray
    cell.detailTextLabel?.numberOfLines = 0
    
    switch property {
    case MoreProperties.ionRadius:
      var stringText = "Unknown"
      let originalLabelColor = cell.detailTextLabel?.textColor
      cell.detailTextLabel?.textColor = UIColor.gray
      if let valueDict = value as? [String: Double] {
        for (key, item) in valueDict {
          let ionName = key
          let radius  = item
          stringText = "(\(ionName)) : \(radius) \(unit ?? "")\n"
          cell.detailTextLabel?.textColor = originalLabelColor
        }
        cell.detailTextLabel?.text = stringText
      }
      return cell
    case MoreProperties.crustAbundance, MoreProperties.humanAbundance, MoreProperties.oceanAbundance, MoreProperties.solarAbundance, MoreProperties.meteorAbundance, MoreProperties.universeAbundance:
      var stringText = ""
      if let value = value as? Double {
        let limit = 0.0000001
        let percentage = value * 100
        let difference = abs(limit - value)
        
        switch difference {
        case let x where x < limit:
          stringText = "Almost Zero".localize(withComment: "Almost Zero Abundance")
        default:
          stringText = String(describing: percentage).capitalized + " \(unit ?? "")"
        }
        cell.detailTextLabel?.text = stringText
      } else {
        modifyUnknownCell(cell: cell)
      }
      return cell
    default:
        if let value = value {
          cell.detailTextLabel?.text = String(describing: value).capitalized + " \(unit ?? "")"
        } else {
          modifyUnknownCell(cell: cell)
        }
        return cell
    }
  }
  
  private func createPropertiesValueDictionary() -> [String: Any?] {
    let dictionary: [String: Any?] = [ MoreProperties.vickers: element.advancedProperties.hardness.vickers,
                                       MoreProperties.mohs: element.advancedProperties.hardness.mohs,
                                       MoreProperties.brinell: element.advancedProperties.hardness.brinell,
                                       MoreProperties.covalentRadius: element.advancedProperties.atomicRadius.covalent,
                                       MoreProperties.empiricalRadius: element.advancedProperties.atomicRadius.empirical,
                                       MoreProperties.vanderWaalsRadius: element.advancedProperties.atomicRadius.vanDerWaals,
                                       MoreProperties.calculatedRadius: element.advancedProperties.atomicRadius.calculated,
                                       MoreProperties.ionRadius: element.advancedProperties.atomicRadius.ion,
                                       MoreProperties.youngModulus: element.advancedProperties.modulus.young,
                                       MoreProperties.shearModulus: element.advancedProperties.modulus.shear,
                                       MoreProperties.bulkModulus: element.advancedProperties.modulus.bulk,
                                       MoreProperties.electricalConductivity: element.advancedProperties.conductivity.electric,
                                       MoreProperties.thermalConductivity: element.advancedProperties.conductivity.thermal,
                                       MoreProperties.specificHeat: element.advancedProperties.heatProperties.specificHeat,
                                       MoreProperties.vaporHeat: element.advancedProperties.heatProperties.vaporizationHeat,
                                       MoreProperties.fusionHeat: element.advancedProperties.heatProperties.fusionHeat,
                                       MoreProperties.universeAbundance: element.advancedProperties.abundace.inUniverse,
                                       MoreProperties.solarAbundance: element.advancedProperties.abundace.inSolar,
                                       MoreProperties.meteorAbundance: element.advancedProperties.abundace.inMeteor,
                                       MoreProperties.crustAbundance: element.advancedProperties.abundace.inCrust,
                                       MoreProperties.oceanAbundance: element.advancedProperties.abundace.inOcean,
                                       MoreProperties.humanAbundance: element.advancedProperties.abundace.inHuman
    ]
    return dictionary
  }
}
