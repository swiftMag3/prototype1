//
//  MyCollectionViewController.swift
//  prototype1
//
//  Created by Swift Mage on 01/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
internal let targetData = URL(fileURLWithPath: "data",
                              relativeTo: FileManager.documentDirectoryURL)
  .appendingPathExtension("json")



class MyCollectionViewController: UICollectionViewController {
  @IBOutlet weak var noResultLabel: UILabel!
  
  let searchController = UISearchController(searchResultsController: nil)
  private var elementIcons: [ElementIcon] = [ElementIcon()]
  private var filteredElements: [ElementIcon] = []
  private var groupDictionary = [String: [ElementIcon]]()
  private var groupTitles = ["nonmetal".localize(withComment: "Section Header"),
                     "alkali metal".localize(withComment: "Section Header"),
                     "alkaline earth metal".localize(withComment: "Section Header"),
                     "metalloid".localize(withComment: "Section Header"),
                     "metal".localize(withComment: "Section Header"),
                     "transition metal".localize(withComment: "Section Header"),
                     "noble gas".localize(withComment: "Section Header"),
                     "lanthanoid".localize(withComment: "Section Header"),
                     "actinoid".localize(withComment: "Section Header"),
                     "post-transition metal".localize(withComment: "Section Header")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    noResultLabel.isHidden = true
    // Setup the database

    loadIconData(to: &elementIcons)

    createGroupDictionary() // Creating groups
    
    // Setup the cell size
    let width = (view.frame.size.width - 60) / 5
    let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: width, height: width)
    layout.sectionHeadersPinToVisibleBounds = true
    collectionView?.showsVerticalScrollIndicator = false
    
    // Setup the Search Controller
    navigationController?.navigationBar.prefersLargeTitles = true
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search element".localize(withComment: "Search bar placeholder")
    navigationItem.searchController = searchController
    definesPresentationContext = true
    
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowDetail" {
      if let detailVC = segue.destination as? DetailViewController, let index = sender as? IndexPath {
        var elementIconData = ElementIcon()
        
        if isFiltering() {
          elementIconData = filteredElements[index.row]
        } else {
          let groupName = groupTitles[index.section]
          if let elementsGrouped = groupDictionary[groupName] {
            elementIconData = elementsGrouped[index.row]
          }
        }
        detailVC.atomicNumber = elementIconData.atomicNumber
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    if isFiltering() {
      return 1
    } else {
      return groupTitles.count
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredElements.count
    }
    let groupName = groupTitles[section]
    guard let elementsGrouped = groupDictionary[groupName] else { return 0 }
    return elementsGrouped.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
    var elementIconData: ElementIcon?
    let cpkColor: String?
    
    if isFiltering() {
      elementIconData = filteredElements[indexPath.row]
    } else {
      let groupName = groupTitles[indexPath.section]
      if let elementsGrouped = groupDictionary[groupName] {
        elementIconData = elementsGrouped[indexPath.row]
      }
      noResultLabel.isHidden = true
    }
    if let elementIconData = elementIconData {
      cell.loadingIndicator.alpha = 0
      cpkColor = elementIconData.cpkColor
      cell.label.text = elementIconData.elementSymbol
      cell.atomicMassLabel.text = String(format: "%.0f", elementIconData.atomicMass)
      cell.atomicNumberLabel.text =  "\(elementIconData.atomicNumber)"
      cell.backgroundColor = UIColor(hex: cpkColor ?? "ffffff")
      cell.label.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
      cell.atomicMassLabel.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
      cell.atomicNumberLabel.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)

      // corner radius
      let width = (view.frame.size.width - 60) / 5
      cell.layer.cornerRadius = CGFloat(Int(width / 4))
      cell.layer.masksToBounds = true
    }
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
    if isFiltering() {
      sectionHeader.title = "Search Result".localize(withComment: "Search result section header")
    } else {
      sectionHeader.title = groupTitles[indexPath.section].capitalized
    }
    
    
    return sectionHeader
  }
  // MARK: UICollectionViewDelegate
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "ShowDetail", sender: indexPath)
  }
  
  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment this method to specify if the specified item should be selected
   override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
   
   }
   */
  
}

// MARK: - Helper Methods
extension MyCollectionViewController {
  // Copy bundled json to docdirectory
  func copyLocalJSONtoDocumentDirectory() {
    guard let bundledJSON = Bundle.main.url(forResource: "data",
                                            withExtension: "json"),
      let jsonData = try? Data(contentsOf: bundledJSON) else {
        debugPrint("data.json is not in the bundle")
        return
    }
    
    do {
      try jsonData.write(to: targetData, options: .atomic)
      debugPrint("file copied successfully")
    } catch let error as NSError{
      print(error)
    }
  }
  
  // load database to elements array
  func loadIconData(to array: inout [ElementIcon]) {
    guard array.count != 118 else {
      debugPrint("array already exists")
      return
    }
    
    print("array is empty")
    
    if !FileManager.default.fileExists(atPath: targetData.path) {
      copyLocalJSONtoDocumentDirectory()
    } else {
      debugPrint("data.json already exists")
    }
    array = loadIconsData()
  }
  
  // Create dictionary for sectioning
  func createGroupDictionary() {
    for element in elementIcons {
      let groupName = element.localizedGroup
      
      if var elementsGrouped = groupDictionary[groupName] {
        elementsGrouped.append(element)
        groupDictionary[groupName] = elementsGrouped
      } else {
        groupDictionary[groupName] = [element]
      }
    }
  }
  
  // MARK: - Search Bar Helper Methods
  func searchBarIsEmpty() -> Bool {
    // Returns true if the text is empty or nil
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    filteredElements = elementIcons.filter({ (elementIcon: ElementIcon) -> Bool in
      let isName = elementIcon.elementName.lowercased().contains(searchText.lowercased())
        || elementIcon.localizedName.lowercased().contains(searchText.lowercased())
      let isSymbol = elementIcon.elementSymbol.lowercased().contains(searchText.lowercased())
      let isNumber = String(elementIcon.atomicNumber).contains(searchText)
      let isGroup = elementIcon.elementGroup.lowercased().contains(searchText.lowercased()) || elementIcon.localizedGroup.lowercased().contains(searchText.lowercased()) || elementIcon.elementIUPAC.lowercased().contains(searchText.lowercased()) || elementIcon.localizedIUPAC.lowercased().contains(searchText.lowercased())
      let showElement = isName || isSymbol || isNumber || isGroup
      
      return showElement
    })
    // No Result Label
    if isFiltering() && filteredElements.count == 0 {
      noResultLabel.text = "No result found for \"\(searchText)\"\n\n Please try another keyword, using the atomic number, name, group or symbol of the elements".localize(withComment: "No Result Text")
      noResultLabel.isHidden = false
    } else {
      noResultLabel.isHidden = true
    }
    collectionView?.reloadData()
  }
  
  func isFiltering() -> Bool {
    return searchController.isActive && !searchBarIsEmpty()
  }
}

// MARK: - UISearchResultUpdating Delegate Extension
extension MyCollectionViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
}
