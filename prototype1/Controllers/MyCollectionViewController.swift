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

  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Setup the database
    loadIconData(to: &elementIcons)
    
    
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
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredElements.count
    }
    
    return elementIcons.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
    let elementIconData: ElementIcon
    if isFiltering() {
      elementIconData = filteredElements[indexPath.row]
    } else {
      elementIconData = elementIcons[indexPath.row]
    }
    let cpkColor = elementIconData.cpkColor
    cell.label.text = elementIconData.elementSymbol
    cell.backgroundColor = UIColor(hex: cpkColor ?? "ffffff")
    cell.label.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
    
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
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
