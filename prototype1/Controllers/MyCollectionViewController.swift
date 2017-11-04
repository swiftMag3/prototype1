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
  
  let searchController = UISearchController(searchResultsController: nil)
  private var elementIcons: [ElementIcon] = [ElementIcon()]
  private var filteredElements: [ElementIcon] = []
  var groupDictionary = [String: [ElementIcon]]()
  var groupTitles = ["nonmetal".localize(withComment: "Section Header"),
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
    // Setup the database
    loadIconData(to: &elementIcons)
    createGroupDictionary() // Creating groups
    
    // Setup the cell size
    let width = (view.frame.size.width - 60) / 5
    let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: width, height: width)
    
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
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   }
   */
  
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
    var elementIconData = ElementIcon()
    let cpkColor: String?
    if isFiltering() {
      elementIconData = filteredElements[indexPath.row]
    } else {
      let groupName = groupTitles[indexPath.section]
      if let elementsGrouped = groupDictionary[groupName] {
        elementIconData = elementsGrouped[indexPath.row]
      }
    }
    cpkColor = elementIconData.cpkColor
    cell.label.text = elementIconData.elementSymbol
    cell.backgroundColor = UIColor(hex: cpkColor ?? "ffffff")
    cell.label.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
    
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
  
  //  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  //    let item = elementIcons[indexPath.row]
  //    let name = item.elementName
  //    print(name)
  //  }
  
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
        print("data.json is not in the bundle")
        return
    }
    
    do {
      try jsonData.write(to: targetData, options: .atomic)
      print("file copied successfully")
    } catch let error as NSError{
      print(error)
    }
  }
  
  // load database to elements array
  func loadIconData(to array: inout [ElementIcon]) {
    guard array.count != 118 else {
      print("array already exists")
      return
    }
    
    print("array is empty")
    
    if !FileManager.default.fileExists(atPath: targetData.path) {
      copyLocalJSONtoDocumentDirectory()
    } else {
      print("data.json already exists")
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
