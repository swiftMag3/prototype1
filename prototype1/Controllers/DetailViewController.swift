////
////  DetailViewController.swift
////  prototype1
////
////  Created by Swift Mage on 06/11/2017.
////  Copyright © 2017 Swift Mage. All rights reserved.
////
//
//import UIKit
//import SwiftyJSON
//
//
//
//private enum CellType: String {
//  case Cell = "Cell"
//  case MoreCell = "MoreCell"
//  case CollectionCell = "CollectionCell"
//}
//
//class DetailViewController: UITableViewController {
//
//  private let unitDictionary: [String: String?] = [Properties.symbol: nil,
//                                                   Properties.atomicNumber: nil,
//                                                   Properties.groupPeriod: nil,
//                                                   Properties.atomicMass: nil,
//                                                   Properties.standarState: nil,
//                                                   Properties.elementCategory: nil,
//                                                   Properties.yearDiscovered: nil,
//                                                   Properties.density: "kg/m{3}",
//                                                   Properties.electronConfiguration: nil,
//                                                   Properties.valence: nil,
//                                                   Properties.electronegativity: nil,
//                                                   Properties.electronAffinity: "kJ/mol",
//                                                   Properties.ionizationEnergy: "kJ/mol",
//                                                   Properties.oxidationState: nil,
//                                                   Properties.bondingType: nil,
//                                                   Properties.meltingPoint: "K",
//                                                   Properties.boilingPoint: "K",
//                                                   Properties.atomicRadius: nil,
//                                                   Properties.hardness: nil,
//                                                   Properties.modulus: nil,
//                                                   Properties.conductivity: nil,
//                                                   Properties.heat: nil,
//                                                   Properties.abundance: nil
//  ]
//  private let propertiesName: [String] = [Properties.symbol,
//                                          Properties.atomicNumber,
//                                          Properties.groupPeriod,
//                                          Properties.atomicMass,
//                                          Properties.standarState,
//                                          Properties.elementCategory,
//                                          Properties.yearDiscovered,
//                                          Properties.density,
//                                          Properties.electronConfiguration,
//                                          Properties.valence,
//                                          Properties.electronegativity,
//                                          Properties.electronAffinity,
//                                          Properties.ionizationEnergy,
//                                          Properties.oxidationState,
//                                          Properties.bondingType,
//                                          Properties.meltingPoint,
//                                          Properties.boilingPoint,
//                                          Properties.atomicRadius,
//                                          Properties.hardness,
//                                          Properties.modulus,
//                                          Properties.conductivity,
//                                          Properties.heat,
//                                          Properties.abundance
//  ]
//
//  var theElement: Element_?
//  private var element: Element!
//  private var propertiesValueDictionary: [String: Any?] = [:]
//  private var filteredProperty: [String] = []
//  var atomicNumber: Int!
//  // For Collection Views
//  private var elements: [Element_] = []
//  private var elementsFilteredByGroup = [Element_]()
//  private var elementsFilteredByPeriod = [Element_]()
//  private var collectionViewIsLoaded = false
//
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    element = loadElement(number: atomicNumber).first
//    title = element?.elementID.localizedName
//    propertiesValueDictionary = createPropertiesValueDictionary()
//    collectionViewIsLoaded = false
//    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(popControllers))
//
//  }
//
//  // remove all the controller and go to root controllers
//  @objc func popControllers() {
//    navigationController?.popToRootViewController(animated: true)
//  }
//
//  override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//  }
//
//  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    guard let tableViewCell = cell as? SameGroupElementCell else { return }
//
//
//    if indexPath.row >= propertiesName.count {
//      tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
//    }
//  }
//
//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    // #warning Incomplete implementation, return the number of rows
//    return propertiesName.count + 2
//  }
//
//  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    switch indexPath.row {
//    case propertiesName.count... :
//      return 83
//    default:
//      return tableView.rowHeight
//    }
//
//  }
//
//  // TODO: - Make the properties Searchable
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    if indexPath.row < propertiesName.count {
//      let property = propertiesName[indexPath.row]
//      let value = propertiesValueDictionary[property]!
//      let unit = unitDictionary[property]!
//
//      switch property {
//      case Properties.atomicRadius, Properties.hardness, Properties.modulus, Properties.conductivity, Properties.heat, Properties.abundance:
//        return makeAPropertyCell(indexPath: indexPath, identifier: CellType.MoreCell.rawValue, for: property, with: value, unit: unit)
//      default:
//        return makeAPropertyCell(indexPath: indexPath, identifier: CellType.Cell.rawValue, for: property, with: value, unit: unit)
//      }
//    } else {
//      let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath) as! SameGroupElementCell
//      cell.stickySectionHeader()
//
//
//      if !collectionViewIsLoaded {
//        cell.loadingIndicator.alpha = 1
//        cell.loadingIndicator.startAnimating()
//        DispatchQueue.global(qos: .default).async {
//          self.loadIconsData(handler: { [unowned self] (results) in
//            DispatchQueue.main.async {
//              self.elements = results
//              self.elementsFilteredByGroup = self.elements.filter({ (theElement) -> Bool in
//                theElement.elementLocation.column == self.element.elementID.elementPosition.column && theElement.elementSymbol != self.element.elementID.symbol
//              })
//              self.elementsFilteredByPeriod = self.elements.filter({ (theElement) -> Bool in
//                theElement.elementLocation.row == self.element.elementID.elementPosition.row && theElement.elementSymbol != self.element.elementID.symbol
//              })
//              self.collectionViewIsLoaded = true
//              cell.loadingIndicator.alpha = 0
//              cell.loadingIndicator.stopAnimating()
//              cell.reloadCollectionView()
//            }
//          })
//        }
//      }
//
//
//      return cell
//    }
//  }
//
//
//  // MARK: - Navigation
//
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "MoreDetail" {
//      if let moreDetailVC = segue.destination as? MoreDetailViewController {
//        let indexPath = tableView.indexPathsForSelectedRows!.first!
//        let cell = tableView.cellForRow(at: indexPath)!
//        let label = cell.textLabel!.text!
//        moreDetailVC.propertyName = label
//        moreDetailVC.element = element
//      }
//    }
//  }
//
//}
//
//// MARK: - Collection View Data Source & Delegate
//extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    switch collectionView.tag {
//    case propertiesName.count:
//      return elementsFilteredByGroup.count
//    default:
//      return elementsFilteredByPeriod.count
//    }
//  }
//
////  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
////    guard cell is GroupedCollectionViewCell else { return }
////
////    if !collectionViewIsLoaded {
////      loadIconsData(handler: { [unowned self] (results) in
////        DispatchQueue.main.async {
////          self.elements = results
////          self.elementsFilteredByGroup = self.elements.filter({ (theElement) -> Bool in
////            theElement.elementLocation.column == self.element.elementID.elementPosition.column && theElement.elementSymbol != self.element.elementID.symbol
////          })
////          self.elementsFilteredByPeriod = self.elements.filter({ (theElement) -> Bool in
////            theElement.elementLocation.row == self.element.elementID.elementPosition.row && theElement.elementSymbol != self.element.elementID.symbol
////          })
////          self.collectionViewIsLoaded = true
////          collectionView.reloadData()
////
////          let indexPath1 = IndexPath(row: self.propertiesName.count, section: 1)
////          let indexPath2 = IndexPath(row: self.propertiesName.count + 1, section: 1)
////          self.tableView.reloadRows(at: [indexPath1, indexPath2], with: .automatic)
////        }
////      })
////    }
////  }
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementCell", for: indexPath) as! GroupedCollectionViewCell
//    let width = (view.frame.size.width - 60) / 5
//    cell.layer.cornerRadius = CGFloat(Int(width / 4))
//    cell.layer.masksToBounds = true
//    collectionView.showsHorizontalScrollIndicator = false
//
//    if !elements.isEmpty {
//      switch collectionView.tag {
//      case propertiesName.count:
//        cell.elementLabel.text = elementsFilteredByGroup[indexPath.row].elementSymbol
//        cell.atomicNumberLabel.text = "\(elementsFilteredByGroup[indexPath.row].atomicNumber)"
//        cell.atomicMassLabel.text = String(format: "%.0f", elementsFilteredByGroup[indexPath.row].atomicMass)
//        cell.backgroundColor = UIColor(hex:  elementsFilteredByGroup[indexPath.row].cpkColor ?? "ffffff")
//        cell.elementLabel.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
//        cell.atomicMassLabel.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
//        cell.atomicNumberLabel.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
//        return cell
//      default:
//        cell.elementLabel.text = elementsFilteredByPeriod[indexPath.row].elementSymbol
//        cell.atomicNumberLabel.text = "\(elementsFilteredByPeriod[indexPath.row].atomicNumber)"
//        cell.atomicMassLabel.text = String(format: "%.0f", elementsFilteredByPeriod[indexPath.row].atomicMass)
//        cell.backgroundColor = UIColor(hex:  elementsFilteredByPeriod[indexPath.row].cpkColor ?? "ffffff")
//        cell.elementLabel.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
//        cell.atomicMassLabel.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
//        cell.atomicNumberLabel.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
//      }
//    }
//    return cell
//
//  }
//
//  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//    let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! SectionHeaderForDetailView
//    sectionHeader.rotateLabel()
//    switch collectionView.tag {
//    case propertiesName.count:
//      sectionHeader.title = "Group \(element.elementID.elementPosition.column)".localize(withComment: "Section Header")
//    default:
//      sectionHeader.title = "Period \(element.elementID.elementPosition.row)".localize(withComment: "Section Header")
//    }
//
//    return sectionHeader
//  }
//
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    var elementIconData: Element_
//
//    switch collectionView.tag {
//    case propertiesName.count:
//      elementIconData = elementsFilteredByGroup[indexPath.row]
//    default:
//      elementIconData = elementsFilteredByPeriod[indexPath.row]
//    }
//
//    let vc = storyboard.instantiateViewController(withIdentifier: "ElementDetail") as! DetailViewController
//    vc.atomicNumber = elementIconData.atomicNumber
//    self.navigationController?.pushViewController(vc, animated: true)
//  }
//}
//
//// MARK: Extension Helper methods
//extension DetailViewController {
//  private func modifyUnknownCell(cell: UITableViewCell) {
//    cell.detailTextLabel?.text = UnknownValue.string
//    cell.detailTextLabel?.textColor = UIColor.gray
//  }
//
//  private func makeAPropertyCell(indexPath: IndexPath, identifier: String, for property: String, with value: Any?, unit: String?) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//    cell.textLabel?.text = property
//    cell.textLabel?.textColor = UIColor.gray
//    cell.detailTextLabel?.numberOfLines = 0
//
//    switch property {
//    case Properties.electronConfiguration:
//      if let value = value {
//        cell.detailTextLabel?.text = String(describing: value) + " \(unit ?? "")"
//      } else {
//        modifyUnknownCell(cell: cell)
//      }
//      return cell
//    case Properties.density:
//      if let value = value {
//        let superscriptText = String(describing: value as! Double * 1000).capitalized + " \(unit ?? "")"
//        let finalSuperscriptText: NSMutableAttributedString = superscriptText.customText()
//        cell.detailTextLabel?.attributedText = finalSuperscriptText
//      } else {
//        modifyUnknownCell(cell: cell)
//      }
//      return cell
//    default:
//      if let value = value {
//        cell.detailTextLabel?.text = String(describing: value).capitalized + " \(unit ?? "")"
//      } else {
//        modifyUnknownCell(cell: cell)
//      }
//      return cell
//    }
//  }
//
//  private func createPropertiesValueDictionary() -> [String: Any?] {
//    let dictionary: [String: Any?] = [ Properties.symbol: element.elementID.symbol,
//                                       Properties.atomicNumber: element.elementID.atomicNumber,
//                                       Properties.groupPeriod: element.elementID.elementPosition,
//                                       Properties.atomicMass: element.basicProperties.atomicMass,
//                                       Properties.standarState: element.basicProperties.localizedState,
//                                       Properties.elementCategory: element.elementID.localizedGroup,
//                                       Properties.yearDiscovered: element.elementID.yearDiscovered,
//                                       Properties.density: element.basicProperties.density,
//                                       Properties.electronConfiguration: element.basicProperties.electronicConfiguration,
//                                       Properties.valence: element.basicProperties.valence,
//                                       Properties.electronegativity: element.advancedProperties.electronegativity,
//                                       Properties.electronAffinity: element.advancedProperties.electronAffinity,
//                                       Properties.ionizationEnergy: element.advancedProperties.ionizationEnergy,
//                                       Properties.oxidationState: element.advancedProperties.oxidationStates,
//                                       Properties.bondingType: element.basicProperties.bondingType,
//                                       Properties.meltingPoint: element.basicProperties.meltingPoint,
//                                       Properties.boilingPoint: element.basicProperties.boilingPoint,
//                                       Properties.atomicRadius: element.advancedProperties.atomicRadius,
//                                       Properties.hardness: element.advancedProperties.hardness,
//                                       Properties.modulus: element.advancedProperties.modulus,
//                                       Properties.conductivity: element.advancedProperties.conductivity,
//                                       Properties.heat: element.advancedProperties.heatProperties,
//                                       Properties.abundance: element.advancedProperties.abundace
//    ]
//    return dictionary
//  }
//
//}
//
//// Load the element data
//extension DetailViewController {
//  // It needs to return an array because the Element class has no init() method
//  func loadElement(number: Int) -> [Element] {
//    guard let data = try? Data(contentsOf: targetData) else {
//      print("Error: Could not load the data.json in document directory".localize(withComment: "Error message"))
//      return [Element]()
//    }
//    var elements: [Element] = []
//    let json = JSON(data)
//
//    // Mark: - Setting The Properties
//    let result = json["result"][number - 1]
//    // Element ID
//    let atomicNumber = result["atomicNumber"].intValue
//    let symbol = result["symbol"].stringValue
//    let name = result["name"].stringValue
//    let cpkHexColor = result["cpkHexColor"].string
//    let legacyBlock = result["groupBlock", "legacy"].stringValue
//    let iupacBlock = result["groupBlock", "iupac"].string
//    let yearDiscovered = result["yearDiscovered"].stringValue
//    let tableRow = result["location", "row"].intValue
//    let tableColumn = result["location", "column"].intValue
//    let elementPosition = TableLocation(row: tableRow, column: tableColumn)
//
//    let elementID = ElementID(atomicNumber: atomicNumber,
//                              symbol: symbol,
//                              name: name,
//                              cpkHexColor: cpkHexColor,
//                              iupacBlock: iupacBlock,
//                              legacyBlock: legacyBlock,
//                              yearDiscovered: yearDiscovered,
//                              elementPosition: elementPosition)
//
//    // Basic Properties
//    let atomicMass = result["atomicMass"].doubleValue
//    let standardState = result["standardState"].stringValue
//    let density = result["density"].double
//    let electronConfiguration = result["electronicConfiguration"].stringValue
//    let valence = result["valence"].intValue
//    let meltingPoint = result["meltingPoint"].double
//    let boilingPoint = result["boilingPoint"].double
//    let bondingType = result["bondingType"].string
//
//    let basicProperties = BasicProperties(atomicMass: atomicMass,
//                                          standardState: standardState,
//                                          density: density,
//                                          electronicConfiguration: electronConfiguration,
//                                          valence: valence,
//                                          meltingPoint: meltingPoint,
//                                          boilingPoint: boilingPoint,
//                                          bondingType: bondingType)
//
//    // Advanced Properties
//    let electronegativity = result["electronegativity"].double
//    let electronAffinity = result["electronAffinity"].double
//    let ionizationEnergy = result["ionizationEnergy"].double
//    let oxidationStates = result["oxidationStates"].string
//    //AtomicRadius
//    let vanDerWaals = result["atomicRadius", "vanDerWaals"].double
//    let empirical = result["atomicRadius", "empirical"].double
//    let calculated = result["atomicRadius", "calculated"].double
//    let covalent = result["atomicRadius", "covalent"].double
//    let ion = result["ionRadius"].dictionaryObject as? [String: Double]
//    //Hardness
//    let vickers = result["hardness", "vickers"].double
//    let mohs = result["hardness", "mohs"].double
//    let brinell = result["hardness", "brinell"].double
//    //Modulus
//    let young = result["modulus", "young"].double
//    let shear = result["modulus", "shear"].double
//    let bulk = result["modulus", "bulk"].double
//    //Conductivity
//    let electric = result["conductivity", "electric"].double
//    let thermal = result["conductivity", "thermal"].double
//    //Heat
//    let specificHeat = result["heat", "specific"].double
//    let vaporizationHeat = result["heat", "vaporization"].double
//    let fusionHeat = result["heat", "fusion"].double
//    //Abundance
//    let inUniverse = result["abundance", "universe"].double
//    let inSolar = result["abundance", "solar"].double
//    let inMeteor = result["abundance", "meteor"].double
//    let inCrust = result["abundance", "crust"].double
//    let inOcean = result["abundance", "ocean"].double
//    let inHuman = result["abundance", "human"].double
//
//
//
//
//    let atomicRadius = AtomicRadius(vanDerWaals: vanDerWaals,
//                                    empirical: empirical,
//                                    calculated: calculated,
//                                    covalent: covalent,
//                                    ion: ion)
//
//    let hardness = Hardness(vickers: vickers,
//                            mohs: mohs,
//                            brinell: brinell)
//    let modulus = Modulus(young: young, shear: shear, bulk: bulk)
//    let conductivity = Conductivity(electric: electric, thermal: thermal)
//    let heatProperties = HeatProperties(specificHeat: specificHeat,
//                                        vaporizationHeat: vaporizationHeat,
//                                        fusionHeat: fusionHeat)
//    let abundace = Abundance(inUniverse: inUniverse,
//                             inSolar: inSolar,
//                             inMeteor: inMeteor,
//                             inCrust: inCrust,
//                             inOcean: inOcean,
//                             inHuman: inHuman)
//
//    let advancedProperties = AdvancedProperties(electronegativity: electronegativity,
//                                                electronAffinity: electronAffinity,
//                                                ionizationEnergy: ionizationEnergy,
//                                                oxidationStates: oxidationStates,
//                                                atomicRadius: atomicRadius,
//                                                hardness: hardness,
//                                                modulus: modulus,
//                                                conductivity: conductivity,
//                                                heatProperties: heatProperties,
//                                                abundace: abundace)
//
//    let newElement = Element(elementID: elementID,
//                             basicProperties: basicProperties,
//                             advancedProperties: advancedProperties)
//    elements.append(newElement)
//    return elements
//  }
//
//
//  func loadIconsData(handler: @escaping ([Element_]) -> ()) {
//
//    guard let data = try? Data(contentsOf: targetData) else {
//      debugPrint("Error: Could not load the data.json in document directory".localize(withComment: "Error message"))
//      return
//    }
//
//    var iconsData: [Element_] = []
//
//    let json = JSON(data)
//    let totalElements = json["result"].arrayValue.count
//
//    for index in 0..<totalElements {
//      let result = json["result"][index]
//      let atomicNumber = result["atomicNumber"].intValue
//      let elementSymbol = result["symbol"].stringValue
//      let elementName = result["name"].stringValue
//      let elementGroup = result["groupBlock", "legacy"].stringValue
//      let elementIUPAC = result["groupBlock", "iupac"].string ?? "Unknown"
//      let tableRow = result["location", "row"].intValue
//      let tableColumn = result["location", "column"].intValue
//      let elementLocation = TableLocation(row: tableRow, column: tableColumn)
//      let cpkColor = result["cpkHexColor"].string
//      let atomicMass = result["atomicMass"].doubleValue
//
//      let iconData = Element_(atomicNumber: atomicNumber, elementSymbol: elementSymbol, elementName: elementName, elementGroup: elementGroup, elementIUPAC: elementIUPAC, elementLocation: elementLocation, cpkColor: cpkColor, atomicMass: atomicMass)
//      iconsData.append(iconData)
//    }
//
//    handler(iconsData)
//  }
//
//}
//
//
//
