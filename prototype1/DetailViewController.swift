//
//  DetailViewController.swift
//  prototype1
//
//  Created by Swift Mage on 06/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import RealmSwift

private enum CellType: String {
  case Cell = "Cell"
  case MoreCell = "MoreCell"
  case CollectionCell = "CollectionCell"
}

enum Constant: CGFloat {
  case tableViewCellHeightForCollectionView = 83
  case collectionViewCellWidth = 62
}

class DetailViewController: UITableViewController {
  @IBOutlet weak var homeButton: UIBarButtonItem!
  @IBOutlet weak var periodicTableViewButton: UIBarButtonItem!
  
  // Collection View Cell properties
  private var elementsFilteredByGroup: Results<ElementRealm>!
  private var elementsFilteredByPeriod: Results<ElementRealm>!

  // Search Result Controller
  let searchController = UISearchController(searchResultsController: nil)
  private var filteredProperties: [ElementRealm.Properties] = []
  private let noResultLabel = UILabel()
  private var cellAtIndexPathRowLoaded: [Int: Bool] = [:]
  
  
  private let properties: [ElementRealm.Properties] = [ElementRealm.Properties.symbol,
                                                       ElementRealm.Properties.atomicNumber,
                                                       ElementRealm.Properties.groupPeriod,
                                                       ElementRealm.Properties.atomicMass,
                                                       ElementRealm.Properties.standardState,
                                                       ElementRealm.Properties.elementCategory,
                                                       ElementRealm.Properties.yearDiscovered,
                                                       ElementRealm.Properties.density,
                                                       ElementRealm.Properties.electronConfiguration,
                                                       ElementRealm.Properties.valence,
                                                       ElementRealm.Properties.electronegativity,
                                                       ElementRealm.Properties.electronAffinity,
                                                       ElementRealm.Properties.ionizationEnergy,
                                                       ElementRealm.Properties.oxidationState,
                                                       ElementRealm.Properties.bondingType,
                                                       ElementRealm.Properties.meltingPoint,
                                                       ElementRealm.Properties.boilingPoint,
                                                       ElementRealm.Properties.atomicRadius,
                                                       ElementRealm.Properties.hardness,
                                                       ElementRealm.Properties.modulus,
                                                       ElementRealm.Properties.conductivity,
                                                       ElementRealm.Properties.heat,
                                                       ElementRealm.Properties.abundance]
  
  var theElement: ElementRealm?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = theElement?.localizedName
    // Search Result Controller Setup
    navigationController?.navigationBar.prefersLargeTitles = true
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search property".localize(withComment: "Search bar placeholder")
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
  @IBAction func goToHome(_ sender: Any) {
    popControllers()
  }

  // remove all the controller and go to root controllers
  @objc private func popControllers() {
    navigationController?.popToRootViewController(animated: true)
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if !isFiltering() {
      // Set Up datasource and delegate for collection View
      if indexPath.row >= properties.count {
        guard let cell = cell as? SameGroupElementCell else { return }
        cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
      }
      // query for same group and period
      if indexPath.row == properties.count {
        elementsFilteredByGroup = try! Realm().objects(ElementRealm.self).filter("elementColumn = \(theElement!.elementColumn) AND atomicNumber != \(theElement!.atomicNumber)")
      } else if indexPath.row == properties.count + 1 {
        elementsFilteredByPeriod = try! Realm().objects(ElementRealm.self).filter("elementRow = \(theElement!.elementRow) AND atomicNumber != \(theElement!.atomicNumber)")
      }
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredProperties.count
    } else {
      return properties.count + 2 // 2 for additional collection view cells
    }
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case properties.count... :
      return Constant.tableViewCellHeightForCollectionView.rawValue
    default:
      return UITableViewAutomaticDimension
    }
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if isFiltering() {
      let property = filteredProperties[indexPath.row]
      let value = valueForProperty(property)
      let unit = property.unit
      switch property {
      case .atomicRadius, .hardness, .modulus, .conductivity, .heat, .abundance:
        return makeAPropertyCell(indexPath: indexPath, identifier: CellType.MoreCell, for: property, with: value, unit: unit)
      default:
        return makeAPropertyCell(indexPath: indexPath, identifier: CellType.Cell, for: property, with: value, unit: unit)
      }
    } else {
      if indexPath.row < properties.count {
        let property = properties[indexPath.row]
        let value = valueForProperty(property)
        let unit = property.unit
        
        switch property {
        case .atomicRadius, .hardness, .modulus, .conductivity, .heat, .abundance:
          return makeAPropertyCell(indexPath: indexPath, identifier: CellType.MoreCell, for: property, with: value, unit: unit)
        default:
          return makeAPropertyCell(indexPath: indexPath, identifier: CellType.Cell, for: property, with: value, unit: unit)
        }
      } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.CollectionCell.rawValue, for: indexPath) as! SameGroupElementCell
        cell.updateAppearance()
        return cell
      }
    }
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "MoreDetail" {
      let moreDetailVC = segue.destination as! MoreDetailViewController
      let indexPath = tableView.indexPathsForSelectedRows!.first!
      if isFiltering() {
        moreDetailVC.property = filteredProperties[indexPath.row]
      } else {
        moreDetailVC.property = properties[indexPath.row]
      }
      moreDetailVC.theElement = theElement
    }
  }

}

// MARK: - Collection View Data Source & Delegate
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView.tag {
    case properties.count:
      return elementsFilteredByGroup.count
    default:
      return elementsFilteredByPeriod.count
    }
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementCell", for: indexPath) as! GroupedCollectionViewCell
    collectionView.showsHorizontalScrollIndicator = false
    var element: ElementRealm?
    switch collectionView.tag {
    case properties.count:
      element = elementsFilteredByGroup[indexPath.row]
    default:
      element = elementsFilteredByPeriod[indexPath.row]
    }
    cell.updateAppearanceFor(element)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let element = theElement else { return UICollectionReusableView() }
    let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! SectionHeaderForDetailView
    sectionHeader.rotateLabel()
    switch collectionView.tag {
    case properties.count:
      sectionHeader.title = "Group \(element.elementColumn)".localize(withComment: "Section Header")
    default:
      sectionHeader.title = "Period \(element.elementRow)".localize(withComment: "Section Header")
    }
    return sectionHeader
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var element: ElementRealm

    switch collectionView.tag {
    case properties.count:
      element = elementsFilteredByGroup[indexPath.row]
    default:
      element = elementsFilteredByPeriod[indexPath.row]
    }

    let vc = storyboard.instantiateViewController(withIdentifier: "ElementDetail") as! DetailViewController
    vc.theElement = element
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: Extension Helper methods
extension DetailViewController {

  private func makeAPropertyCell(indexPath: IndexPath, identifier: CellType, for property: ElementRealm.Properties, with value: String, unit: String?) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier.rawValue, for: indexPath)
    cell.textLabel?.text = property.name
    cell.textLabel?.textColor = UIColor.gray
    cell.detailTextLabel?.numberOfLines = 0

    switch property {
    case .electronConfiguration:
      cell.detailTextLabel?.text = value + " \(unit ?? "")"
      return cell
    case .density:
      var superscriptText : String {
        var text = ""
        if var newValue = Double(value) {
          newValue = newValue * 1000
          text += String("\(newValue)") + " \(unit ?? "")"
        } else {
          text += value
          if text == UnknownValue.string {
            cell.detailTextLabel?.textColor = UIColor.lightGray
          }
        }
        return text
      }
      let finalSuperscriptText: NSMutableAttributedString = superscriptText.customText()
      cell.detailTextLabel?.attributedText = finalSuperscriptText
      return cell
    default:
      if value == UnknownValue.string {
        cell.detailTextLabel?.text = value.capitalized
        cell.detailTextLabel?.textColor = UIColor.lightGray
      } else {
        cell.detailTextLabel?.text = value.capitalized + " \(unit ?? "")"
      }
      return cell
    }
  }

  private func valueForProperty(_ property: ElementRealm.Properties) -> String {
    guard let element = theElement else { return "" }
    let dictionary: [ElementRealm.Properties: String] = [ ElementRealm.Properties.symbol: element.symbol,
                                                      ElementRealm.Properties.atomicNumber: "\(element.atomicNumber)",
      ElementRealm.Properties.groupPeriod: "(\(element.elementRow), \(element.elementColumn))",
      ElementRealm.Properties.atomicMass: "\(element.atomicMass)",
      ElementRealm.Properties.standardState: element.localizedState,
      ElementRealm.Properties.elementCategory: element.localizedGroup,
      ElementRealm.Properties.yearDiscovered: element.yearDiscovered,
      ElementRealm.Properties.density: element.density.value != nil ? "\(element.density.value!)" : UnknownValue.string,
      ElementRealm.Properties.electronConfiguration: element.electronicConfiguration,
      ElementRealm.Properties.valence: "\(element.valence)",
      ElementRealm.Properties.electronegativity: element.electronegativity.value != nil ? "\(element.electronegativity.value!)" : UnknownValue.string,
      ElementRealm.Properties.electronAffinity: element.electronAffinity.value != nil ? "\(element.electronAffinity.value!)" : UnknownValue.string,
      ElementRealm.Properties.ionizationEnergy: element.ionizationEnergy.value != nil ? "\(element.ionizationEnergy.value!)" : UnknownValue.string,
      ElementRealm.Properties.oxidationState: element.oxidationStates,
      ElementRealm.Properties.bondingType: element.bondingType,
      ElementRealm.Properties.meltingPoint: element.meltingPoint.value != nil ? "\(element.meltingPoint.value!)" : UnknownValue.string,
      ElementRealm.Properties.boilingPoint: element.boilingPoint.value != nil ? "\(element.boilingPoint.value!)" : UnknownValue.string,
      ElementRealm.Properties.atomicRadius: "",
      ElementRealm.Properties.hardness: "",
      ElementRealm.Properties.modulus: "",
      ElementRealm.Properties.conductivity: "",
      ElementRealm.Properties.heat: "",
      ElementRealm.Properties.abundance: ""
    ]
    return dictionary[property]!
  }
}

// MARK: - Search Controller Protocol & Helper Methods
extension DetailViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    filterPropertyForSearchText(searchController.searchBar.text!)
  }
  
  // MARK: - Search Bar Helper Methods
  func searchBarIsEmpty() -> Bool {
    // Returns true if the text is empty or nil
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isFiltering() -> Bool {
    return searchController.isActive && !searchBarIsEmpty()
  }
  
  func filterPropertyForSearchText(_ searchText: String, scope: String = "All") {
    filteredProperties = properties.filter { (property: ElementRealm.Properties) -> Bool in
      let show = property.name.lowercased().contains(searchText.lowercased())
      return show
    }
    
    // No Result Lable Set programmatically
    noResultLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 40, height: view.frame.height)
    noResultLabel.center = CGPoint(x: view.center.x, y: view.center.y - 47)
    noResultLabel.isHidden = true
    noResultLabel.textAlignment = .center
    view.addSubview(noResultLabel)

    if isFiltering() && filteredProperties.count == 0 {
      noResultLabel.numberOfLines = 0
      noResultLabel.font = noResultLabel.font.withSize(20)
      noResultLabel.text = "No result found for \(searchText) property"
      noResultLabel.isHidden = false
    } else {
      noResultLabel.isHidden = true
    }
    
    tableView.reloadData()
  }
}



