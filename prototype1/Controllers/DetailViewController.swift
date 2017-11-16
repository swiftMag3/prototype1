//
//  DetailViewController.swift
//  prototype1
//
//  Created by Swift Mage on 06/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

private enum CellType: String {
  case Cell = "Cell"
  case MoreCell = "MoreCell"
  case CollectionCell = "CollectionCell"
}

class DetailViewController: UITableViewController {
  
  lazy var elementsDataSource = ElementsDataSource()
  var loadingQueue = OperationQueue()
  var loadingOperations = [IndexPath: DataLoadOperation]()


  // Collection View Cell properties
  private var elementsFilteredByGroup = [Element_]()
  private var elementsFilteredByPeriod = [Element_]()
  private var collectionViewIsLoaded = false
  // Search Result Controller
  let searchController = UISearchController(searchResultsController: nil)
  private var filteredProperties: [Element_.Properties] = []
  private let noResultLabel = UILabel()
  
  
  private let properties: [Element_.Properties] = [Element_.Properties.symbol,
                                                   Element_.Properties.atomicNumber,
                                                   Element_.Properties.groupPeriod,
                                                   Element_.Properties.atomicMass,
                                                   Element_.Properties.standardState,
                                                   Element_.Properties.elementCategory,
                                                   Element_.Properties.yearDiscovered,
                                                   Element_.Properties.density,
                                                   Element_.Properties.electronConfiguration,
                                                   Element_.Properties.valence,
                                                   Element_.Properties.electronegativity,
                                                   Element_.Properties.electronAffinity,
                                                   Element_.Properties.ionizationEnergy,
                                                   Element_.Properties.oxidationState,
                                                   Element_.Properties.bondingType,
                                                   Element_.Properties.meltingPoint,
                                                   Element_.Properties.boilingPoint,
                                                   Element_.Properties.atomicRadius,
                                                   Element_.Properties.hardness,
                                                   Element_.Properties.modulus,
                                                   Element_.Properties.conductivity,
                                                   Element_.Properties.heat,
                                                   Element_.Properties.abundance]
  
  var theElement: Element_? {
    didSet {
      DispatchQueue.global().async { [unowned self] in
        self.filteringSamePeriodAndGroup(handler: { (finished) in
          DispatchQueue.main.async {
            if !self.isFiltering() {
              let indexPath1 = IndexPath(row: self.properties.count, section: 0)
              let indexPath2 = IndexPath(row: self.properties.count + 1, section: 0)
              self.tableView.reloadRows(at: [indexPath1, indexPath2], with: .automatic)
            }
          }
        })
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = theElement?.localizedName
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(popControllers))
    // Search Result Controller Setup
    navigationController?.navigationBar.prefersLargeTitles = true
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search property".localize(withComment: "Search bar placeholder")
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }

  // remove all the controller and go to root controllers
  @objc private func popControllers() {
    navigationController?.popToRootViewController(animated: true)
  }
  
  private func filteringSamePeriodAndGroup(handler: (Bool) -> ()) {
    guard let theElement = theElement else { return }
    let elements = elementsDataSource.allElements
    elementsFilteredByGroup = elements.filter({ (element) -> Bool in
      element.elementPosition.column == theElement.elementPosition.column && element.symbol != theElement.symbol
    })
    elementsFilteredByPeriod = elements.filter({ (element) -> Bool in
      element.elementPosition.row == theElement.elementPosition.row && element.symbol != theElement.symbol
    })
    collectionViewIsLoaded = true
    handler(true)
  }


  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if !isFiltering() {
      if indexPath.row >= properties.count {
        guard let tableViewCell = cell as? SameGroupElementCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        
        if collectionViewIsLoaded {
          tableViewCell.loadingIndicator.isHidden = true
          tableViewCell.loadingIndicator.stopAnimating()
        } else {
          tableViewCell.loadingIndicator.isHidden = false
          tableViewCell.loadingIndicator.startAnimating()
        }
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
      return 83
    default:
      return UITableViewAutomaticDimension
    }
  }

  // TODO: - Make the properties Searchable
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
        cell.stickySectionHeader()
        return cell
      }
    }
  }


  // MARK: - Navigation

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
    var element: Element_?
    switch collectionView.tag {
    case properties.count:
      element = elementsFilteredByGroup[indexPath.row]
    default:
      element = elementsFilteredByPeriod[indexPath.row]
    }
    cell.updateAppearanceFor(element)
    collectionViewIsLoaded = true
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let element = theElement else { return UICollectionReusableView() }
    let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! SectionHeaderForDetailView
    sectionHeader.rotateLabel()
    switch collectionView.tag {
    case properties.count:
      sectionHeader.title = "Group \(element.elementPosition.column)".localize(withComment: "Section Header")
    default:
      sectionHeader.title = "Period \(element.elementPosition.row)".localize(withComment: "Section Header")
    }
    return sectionHeader
  }

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
}

// MARK: Extension Helper methods
extension DetailViewController {

  private func makeAPropertyCell(indexPath: IndexPath, identifier: CellType, for property: Element_.Properties, with value: String, unit: String?) -> UITableViewCell {
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
          text += String("\(newValue)").capitalized + " \(unit ?? "")"
        } else {
          text += value
        }
        return text
      }
      let finalSuperscriptText: NSMutableAttributedString = superscriptText.customText()
      cell.detailTextLabel?.attributedText = finalSuperscriptText
      return cell
    default:
      if value == "Unknown" {
        cell.detailTextLabel?.text = value.capitalized
        cell.detailTextLabel?.textColor = UIColor.lightGray
      } else {
        cell.detailTextLabel?.text = value.capitalized + " \(unit ?? "")"
      }
      return cell
    }
  }

  private func valueForProperty(_ property: Element_.Properties) -> String {
    if let element = theElement {
      let dictionary: [Element_.Properties: String] = [ Element_.Properties.symbol: element.symbol,
                                           Element_.Properties.atomicNumber: "\(element.atomicNumber)",
        Element_.Properties.groupPeriod: "\(element.elementPosition)",
        Element_.Properties.atomicMass: "\(element.atomicMass)",
        Element_.Properties.standardState: element.localizedState,
        Element_.Properties.elementCategory: element.localizedGroup,
        Element_.Properties.yearDiscovered: element.yearDiscovered,
        Element_.Properties.density: element.density != nil ? "\(element.density!)" : UnknownValue.string,
        Element_.Properties.electronConfiguration: element.electronicConfiguration,
        Element_.Properties.valence: "\(element.valence)",
        Element_.Properties.electronegativity: element.electronegativity != nil ? "\(element.electronegativity!)" : UnknownValue.string,
        Element_.Properties.electronAffinity: element.electronAffinity != nil ? "\(element.electronAffinity!)" : UnknownValue.string,
        Element_.Properties.ionizationEnergy: element.ionizationEnergy != nil ? "\(element.ionizationEnergy!)" : UnknownValue.string,
        Element_.Properties.oxidationState: element.oxidationStates,
        Element_.Properties.bondingType: element.bondingType,
        Element_.Properties.meltingPoint: element.meltingPoint != nil ? "\(element.meltingPoint!)" : UnknownValue.string,
        Element_.Properties.boilingPoint: element.boilingPoint != nil ? "\(element.boilingPoint!)" : UnknownValue.string,
        Element_.Properties.atomicRadius: "",
        Element_.Properties.hardness: "",
        Element_.Properties.modulus: "",
        Element_.Properties.conductivity: "",
        Element_.Properties.heat: "",
        Element_.Properties.abundance: ""
      ]
    return dictionary[property]!
    }
    return ""
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
    filteredProperties = properties.filter { (property: Element_.Properties) -> Bool in
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

