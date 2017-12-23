//
//  MoreDetailViewController.swift
//  prototype1
//
//  Created by Swift Mage on 08/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class MoreDetailViewController: UITableViewController {

  
  private let propertiesNameDictionary: [ElementRealm.Properties: [ElementRealm.MoreProperties]] = [
    ElementRealm.Properties.hardness: [ElementRealm.MoreProperties.vickers,
                          ElementRealm.MoreProperties.mohs,
                          ElementRealm.MoreProperties.brinell],
    ElementRealm.Properties.atomicRadius: [ElementRealm.MoreProperties.covalentRadius,
                              ElementRealm.MoreProperties.empiricalRadius,
                              ElementRealm.MoreProperties.vanDerWaalsRadius,
                              ElementRealm.MoreProperties.calculatedRadius,
                              ElementRealm.MoreProperties.ionRadius],
    ElementRealm.Properties.modulus: [ElementRealm.MoreProperties.youngModulus,
                         ElementRealm.MoreProperties.shearModulus,
                         ElementRealm.MoreProperties.bulkModulus],
    ElementRealm.Properties.conductivity: [ElementRealm.MoreProperties.electricalConductivity,
                              ElementRealm.MoreProperties.thermalConductivity],
    ElementRealm.Properties.heat: [ElementRealm.MoreProperties.specificHeat,
                      ElementRealm.MoreProperties.vaporHeat,
                      ElementRealm.MoreProperties.fusionHeat],
    ElementRealm.Properties.abundance: [ElementRealm.MoreProperties.universeAbundance,
                           ElementRealm.MoreProperties.solarAbundance,
                           ElementRealm.MoreProperties.meteorAbundance,
                           ElementRealm.MoreProperties.crustAbundance,
                           ElementRealm.MoreProperties.oceanAbundance,
                           ElementRealm.MoreProperties.humanAbundance]]
  
  
  var property: ElementRealm.Properties! {
    didSet {
      self.title = property.name
    }
  }
  
  var theElement: ElementRealm!
  private lazy var properties = { () -> [ElementRealm.MoreProperties] in
    return propertiesNameDictionary[property]!
  }()
  
  override var shouldAutorotate: Bool {
    return false
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.portrait
  }
  
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
  
  private func makeAPropertyCell(indexPath: IndexPath, for property: ElementRealm.MoreProperties, with value: String, unit: Unit.RawValue) -> UITableViewCell {
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
  
  private func valueForProperty(_ moreProperty: ElementRealm.MoreProperties) -> String {
    guard let element = theElement else { return "" }
    
    func abundancePercentage(_ value: Double?) -> String {
      guard var value = value else { return UnknownValue.string }
      value *= 100
      return value.decimalFormatted
    }
    
    func ionRadiusToString(_ dict: List<IonRadius>?) -> String {
      guard let dict = dict else { return UnknownValue.string }
      var stringText = ""
      for ionRadius in dict {
        let ionName = ionRadius.ion
        let radius  = ionRadius.radius
        let text = "(\(ionName)) : \(radius)" // NO DATA SHOWS MORE THAN ONE, needs to be changed if in the future there is more than one
        stringText += text
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
    
    let dictionary: [ElementRealm.MoreProperties: String] = [ElementRealm.MoreProperties.vickers: makeAStringFrom(element.vickersHardness.value),
      ElementRealm.MoreProperties.mohs: makeAStringFrom(element.mohsHardness.value),
      ElementRealm.MoreProperties.brinell: makeAStringFrom(element.brinellHardness.value),
      ElementRealm.MoreProperties.covalentRadius: makeAStringFrom(element.covalentRadius.value),
      ElementRealm.MoreProperties.empiricalRadius: makeAStringFrom(element.empiricalRadius.value),
      ElementRealm.MoreProperties.vanDerWaalsRadius: makeAStringFrom(element.vanDerWaalsRadius.value),
      ElementRealm.MoreProperties.calculatedRadius: makeAStringFrom(element.calculatedRadius.value),
      ElementRealm.MoreProperties.ionRadius: ionRadiusToString(element.ionRadius),
      ElementRealm.MoreProperties.youngModulus: makeAStringFrom(element.youngModulus.value),
      ElementRealm.MoreProperties.shearModulus: makeAStringFrom(element.shearModulus.value),
      ElementRealm.MoreProperties.bulkModulus: makeAStringFrom(element.bulkModulus.value),
      ElementRealm.MoreProperties.electricalConductivity: makeAStringFrom(element.electricalConductivity.value),
      ElementRealm.MoreProperties.thermalConductivity: makeAStringFrom(element.thermalConductivity.value),
      ElementRealm.MoreProperties.specificHeat: makeAStringFrom(element.specifictHeat.value),
      ElementRealm.MoreProperties.vaporHeat: makeAStringFrom(element.vaporizationHeat.value),
      ElementRealm.MoreProperties.fusionHeat: makeAStringFrom(element.fusionHeat.value),
      ElementRealm.MoreProperties.universeAbundance: abundancePercentage(element.abundanceInUniverse.value),
      ElementRealm.MoreProperties.solarAbundance: abundancePercentage(element.abundanceInSolar.value),
      ElementRealm.MoreProperties.meteorAbundance: abundancePercentage(element.abundanceInMeteor.value),
      ElementRealm.MoreProperties.crustAbundance: abundancePercentage(element.abundanceInCrust.value),
      ElementRealm.MoreProperties.oceanAbundance: abundancePercentage(element.abundanceInOcean.value),
      ElementRealm.MoreProperties.humanAbundance: abundancePercentage(element.abundaceInHuman.value)]
    
    return dictionary[moreProperty]!
  }
}



