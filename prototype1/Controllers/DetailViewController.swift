//
//  DetailViewController.swift
//  prototype1
//
//  Created by Swift Mage on 06/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import SwiftyJSON



enum CellType: String {
  case Cell = "Cell"
  case MoreCell = "MoreCell"
  case CollectionCell = "CollectionCell"
}

class DetailViewController: UITableViewController {
  
  var atomicNumber: Int!
  private var element: Element!
  private let unitDictionary: [String: String?] = [Properties.symbol: nil,
                                       Properties.atomicNumber: nil,
                                       Properties.groupPeriod: nil,
                                       Properties.atomicMass: nil,
                                       Properties.standarState: nil,
                                       Properties.elementCategory: nil,
                                       Properties.yearDiscovered: nil,
                                       Properties.density: "kg/m{3}",
                                       Properties.electronConfiguration: nil,
                                       Properties.valence: nil,
                                       Properties.electronegativity: nil,
                                       Properties.electronAffinity: "kJ/mol",
                                       Properties.ionizationEnergy: "kJ/mol",
                                       Properties.oxidationState: nil,
                                       Properties.bondingType: nil,
                                       Properties.meltingPoint: "K",
                                       Properties.boilingPoint: "K",
                                       Properties.atomicRadius: nil,
                                       Properties.hardness: nil,
                                       Properties.modulus: nil,
                                       Properties.conductivity: nil,
                                       Properties.heat: nil,
                                       Properties.abundance: nil
  ]
  private let propertiesName: [String] = [Properties.symbol,
                                          Properties.atomicNumber,
                                          Properties.groupPeriod,
                                          Properties.atomicMass,
                                          Properties.standarState,
                                          Properties.elementCategory,
                                          Properties.yearDiscovered,
                                          Properties.density,
                                          Properties.electronConfiguration,
                                          Properties.valence,
                                          Properties.electronegativity,
                                          Properties.electronAffinity,
                                          Properties.ionizationEnergy,
                                          Properties.oxidationState,
                                          Properties.bondingType,
                                          Properties.meltingPoint,
                                          Properties.boilingPoint,
                                          Properties.atomicRadius,
                                          Properties.hardness,
                                          Properties.modulus,
                                          Properties.conductivity,
                                          Properties.heat,
                                          Properties.abundance
  ]
  
  private var propertiesDictionary: [String: Any?] = [:]
  
  private var filteredProperty: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    element = loadElement(number: atomicNumber).first
    title = element?.elementID.localizedName
    propertiesDictionary = createPropertiesDictionary()
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  /*
   override func numberOfSections(in tableView: UITableView) -> Int {
   // #warning Incomplete implementation, return the number of sections
   return 0
   }
   */
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return propertiesName.count
  }
  
  // TODO: - Make the properties Searchable
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let property = propertiesName[indexPath.row]
    let value = propertiesDictionary[property]!
    let unit = unitDictionary[property]!
    
    switch property {
    case Properties.atomicRadius, Properties.hardness, Properties.modulus, Properties.conductivity, Properties.heat, Properties.abundance:
      return makeAPropertyCell(indexPath: indexPath, identifier: CellType.MoreCell.rawValue, for: property, with: value, unit: unit)
    default:
      return makeAPropertyCell(indexPath: indexPath, identifier: CellType.Cell.rawValue, for: property, with: value, unit: unit)
    }
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

// MARK: Extension Helper methods
extension DetailViewController {
  private func modifyUnknownCell(cell: UITableViewCell) {
    cell.detailTextLabel?.text = UnknownValue.string
    cell.detailTextLabel?.textColor = UIColor.gray
  }
  
  private func makeAPropertyCell(indexPath: IndexPath, identifier: String, for property: String, with value: Any?, unit: String?) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    cell.textLabel?.text = property
    cell.textLabel?.textColor = UIColor.gray
    cell.detailTextLabel?.numberOfLines = 0

    switch property {
    case Properties.electronConfiguration:
      if let value = value {
        cell.detailTextLabel?.text = String(describing: value) + " \(unit ?? "")"
      } else {
        modifyUnknownCell(cell: cell)
      }
      return cell
    case Properties.density:
      if let value = value {
        let superscriptText = String(describing: value as! Double * 1000).capitalized + " \(unit ?? "")"
        let finalSuperscriptText: NSMutableAttributedString = superscriptText.customText()
        cell.detailTextLabel?.attributedText = finalSuperscriptText
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
  
  private func createPropertiesDictionary() -> [String: Any?] {
    let dictionary: [String: Any?] = [ Properties.symbol: element.elementID.symbol,
                                       Properties.atomicNumber: element.elementID.atomicNumber,
                                       Properties.groupPeriod: element.elementID.elementPosition,
                                       Properties.atomicMass: element.basicProperties.atomicMass,
                                       Properties.standarState: element.basicProperties.localizedState,
                                       Properties.elementCategory: element.elementID.localizedGroup,
                                       Properties.yearDiscovered: element.elementID.yearDiscovered,
                                       Properties.density: element.basicProperties.density,
                                       Properties.electronConfiguration: element.basicProperties.electronicConfiguration,
                                       Properties.valence: element.basicProperties.valence,
                                       Properties.electronegativity: element.advancedProperties.electronegativity,
                                       Properties.electronAffinity: element.advancedProperties.electronAffinity,
                                       Properties.ionizationEnergy: element.advancedProperties.ionizationEnergy,
                                       Properties.oxidationState: element.advancedProperties.oxidationStates,
                                       Properties.bondingType: element.basicProperties.bondingType,
                                       Properties.meltingPoint: element.basicProperties.meltingPoint,
                                       Properties.boilingPoint: element.basicProperties.boilingPoint,
                                       Properties.atomicRadius: element.advancedProperties.atomicRadius,
                                       Properties.hardness: element.advancedProperties.hardness,
                                       Properties.modulus: element.advancedProperties.modulus,
                                       Properties.conductivity: element.advancedProperties.conductivity,
                                       Properties.heat: element.advancedProperties.heatProperties,
                                       Properties.abundance: element.advancedProperties.abundace
    ]
    return dictionary
  }

}

// Load the element data
extension DetailViewController {
  // It needs to return an array because the Element class has no init() method
  func loadElement(number: Int) -> [Element] {
    guard let data = try? Data(contentsOf: targetData) else {
      print("Error: Could not load the data.json in document directory".localize(withComment: "Error message"))
      return [Element]()
    }
    var elements: [Element] = []
    let json = JSON(data)
    
    // Mark: - Setting The Properties
    let result = json["result"][number - 1]
    // Element ID
    let atomicNumber = result["atomicNumber"].intValue
    let symbol = result["symbol"].stringValue
    let name = result["name"].stringValue
    let cpkHexColor = result["cpkHexColor"].string
    let legacyBlock = result["groupBlock", "legacy"].stringValue
    let iupacBlock = result["groupBlock", "iupac"].string
    let yearDiscovered = result["yearDiscovered"].stringValue
    let tableRow = result["location", "row"].intValue
    let tableColumn = result["location", "column"].intValue
    let elementPosition = TableLocation(row: tableRow, column: tableColumn)
    
    let elementID = ElementID(atomicNumber: atomicNumber,
                              symbol: symbol,
                              name: name,
                              cpkHexColor: cpkHexColor,
                              iupacBlock: iupacBlock,
                              legacyBlock: legacyBlock,
                              yearDiscovered: yearDiscovered,
                              elementPosition: elementPosition)
    
    // Basic Properties
    let atomicMass = result["atomicMass"].doubleValue
    let standardState = result["standardState"].stringValue
    let density = result["density"].double
    let electronConfiguration = result["electronicConfiguration"].stringValue
    let valence = result["valence"].intValue
    let meltingPoint = result["meltingPoint"].double
    let boilingPoint = result["boilingPoint"].double
    let bondingType = result["bondingType"].string
    
    let basicProperties = BasicProperties(atomicMass: atomicMass,
                                          standardState: standardState,
                                          density: density,
                                          electronicConfiguration: electronConfiguration,
                                          valence: valence,
                                          meltingPoint: meltingPoint,
                                          boilingPoint: boilingPoint,
                                          bondingType: bondingType)
    
    // Advanced Properties
    let electronegativity = result["electronegativity"].double
    let electronAffinity = result["electronAffinity"].double
    let ionizationEnergy = result["ionizationEnergy"].double
    let oxidationStates = result["oxidationStates"].string
    //AtomicRadius
    let vanDerWaals = result["atomicRadius", "vanDerWaals"].double
    let empirical = result["atomicRadius", "empirical"].double
    let calculated = result["atomicRadius", "calculated"].double
    let covalent = result["atomicRadius", "covalent"].double
    let ion = result["ionRadius"].dictionaryObject as? [String: Double]
    //Hardness
    let vickers = result["hardness", "vickers"].double
    let mohs = result["hardness", "mohs"].double
    let brinell = result["hardness", "brinell"].double
    //Modulus
    let young = result["modulus", "young"].double
    let shear = result["modulus", "shear"].double
    let bulk = result["modulus", "bulk"].double
    //Conductivity
    let electric = result["conductivity", "electric"].double
    let thermal = result["conductivity", "thermal"].double
    //Heat
    let specificHeat = result["heat", "specific"].double
    let vaporizationHeat = result["heat", "vaporization"].double
    let fusionHeat = result["heat", "fusion"].double
    //Abundance
    let inUniverse = result["abundance", "universe"].double
    let inSolar = result["abundance", "solar"].double
    let inMeteor = result["abundance", "meteor"].double
    let inCrust = result["abundance", "crust"].double
    let inOcean = result["abundance", "ocean"].double
    let inHuman = result["abundance", "human"].double
    
    
    
    
    let atomicRadius = AtomicRadius(vanDerWaals: vanDerWaals,
                                    empirical: empirical,
                                    calculated: calculated,
                                    covalent: covalent,
                                    ion: ion)
    
    let hardness = Hardness(vickers: vickers,
                            mohs: mohs,
                            brinell: brinell)
    let modulus = Modulus(young: young, shear: shear, bulk: bulk)
    let conductivity = Conductivity(electric: electric, thermal: thermal)
    let heatProperties = HeatProperties(specificHeat: specificHeat,
                                        vaporizationHeat: vaporizationHeat,
                                        fusionHeat: fusionHeat)
    let abundace = Abundance(inUniverse: inUniverse,
                             inSolar: inSolar,
                             inMeteor: inMeteor,
                             inCrust: inCrust,
                             inOcean: inOcean,
                             inHuman: inHuman)
    
    let advancedProperties = AdvancedProperties(electronegativity: electronegativity,
                                                electronAffinity: electronAffinity,
                                                ionizationEnergy: ionizationEnergy,
                                                oxidationStates: oxidationStates,
                                                atomicRadius: atomicRadius,
                                                hardness: hardness,
                                                modulus: modulus,
                                                conductivity: conductivity,
                                                heatProperties: heatProperties,
                                                abundace: abundace)
    
    let newElement = Element(elementID: elementID,
                             basicProperties: basicProperties,
                             advancedProperties: advancedProperties)
    elements.append(newElement)
    return elements
  }
}



