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
  
  var elementsDataSource = ElementsDataSource()
  var loadingQueue = OperationQueue()
  var loadingOperations = [IndexPath: DataLoadOperation]()
  
  let searchController = UISearchController(searchResultsController: nil)
  private var filteredElements: [Element_] = []
  private var dataIsLoaded = false
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpDisplay()
  }
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "ShowDetail" {
//      let detailVC = segue.destination as! DetailViewController
//      detailVC.theElement = sender as? Element_
//    }
//  }
}

// MARK: UICollectionViewDataSource
extension MyCollectionViewController {
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    if isFiltering() {
      return 1
    } else {
      return elementsDataSource.numbersOfSection
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredElements.count
    } else {
      return elementsDataSource.numberOfElementsInSection(section)
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
    cell.updateAppearanceFor(nil, animated: false)
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
    if isFiltering() {
      sectionHeader.isHidden = false
      sectionHeader.title = "Search Result".localize(withComment: "Search result section header")
    } else {
      if dataIsLoaded {
        sectionHeader.isHidden = false
        sectionHeader.title = elementsDataSource.titleForSectionAtIndexPath(indexPath).capitalized
      } else {
        sectionHeader.isHidden = true
      }
    }
    return sectionHeader
  }
  // MARK: UICollectionViewDelegate
}

// MARK:- UICollectionViewDelegate
extension MyCollectionViewController {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if var element = elementsDataSource.elementForItemAtIndexPath(indexPath) {
      if isFiltering() {
        element = filteredElements[indexPath.row]
      }
      print(element.localizedGroup, element.name)
      // performSegue(withIdentifier: "ShowDetail", sender: element)
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    guard let cell = cell as? MyCollectionViewCell else { return }
    dataIsLoaded = false
    
    // How should the operation update the cell once the data has been loaded?
    let updateCellClosure: (Element_?) -> () = { [unowned self] (element) in
      cell.updateAppearanceFor(element, animated: true)
      self.loadingOperations.removeValue(forKey: indexPath)
    }
    
    // Try to find an existing data loader
    if let dataLoader = loadingOperations[indexPath] {
      // Has the data already been loaded?
      if let theElement = dataLoader.element {
        cell.updateAppearanceFor(theElement, animated: false)
        loadingOperations.removeValue(forKey: indexPath)
      } else {
        // No data loaded yet, so add the completion closure to update the cell once the data arrives
        dataLoader.loadingCompleteHandler = updateCellClosure
      }
    } else {
      // Need to create a data loaded for this index path
      var dataLoader = DataLoadOperation(Element_())
      if isFiltering() {
        dataLoader = DataLoadOperation(filteredElements[indexPath.row])
      } else {
        if let theElement = elementsDataSource.elementForItemAtIndexPath(indexPath) {
          dataLoader = DataLoadOperation(theElement)
        }
      }
      // Provide the completion closure, and kick off the loading operation
      dataLoader.loadingCompleteHandler = updateCellClosure
      loadingQueue.addOperation(dataLoader)
      loadingOperations[indexPath] = dataLoader
    }
    dataIsLoaded = true
  }
  
  override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    // If there's a data loader for this index path we don't need it any more. Cancel and dispose
    if let dataLoader = loadingOperations[indexPath] {
      dataLoader.cancel()
      loadingOperations.removeValue(forKey: indexPath)
    }
  }
}

// MARK: - Helper Methods
extension MyCollectionViewController {
  
  // MARK: - Search Bar Helper Methods
  func searchBarIsEmpty() -> Bool {
    // Returns true if the text is empty or nil
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    filteredElements = elementsDataSource.allElements.filter({ (element: Element_) -> Bool in
      let isName = element.name.lowercased().contains(searchText.lowercased())
        || element.localizedName.lowercased().contains(searchText.lowercased())
      let isSymbol = element.symbol.lowercased().contains(searchText.lowercased())
      let isNumber = String(element.atomicNumber).contains(searchText)
      let isGroup = element.legacyBlock.lowercased().contains(searchText.lowercased()) || element.localizedGroup.lowercased().contains(searchText.lowercased()) || element.iupacBlock.lowercased().contains(searchText.lowercased()) || element.localizedIUPAC.lowercased().contains(searchText.lowercased())
      let showElement = isName || isSymbol || isNumber || isGroup
      
      return showElement
    })
    
    // No Result Label
    let myCollectionView = collectionView as? MyCollectionView
    if isFiltering() && filteredElements.count == 0 {
      myCollectionView?.helperView.noResultLabel.text = "No result found for \"\(searchText)\"\n\n Please try another keyword, using the atomic number, name, group or symbol of the elements".localize(withComment: "No Result Text")
      myCollectionView?.helperView.noResultLabel.isHidden = false
    } else {
      myCollectionView?.helperView.noResultLabel.isHidden = true
    }
    collectionView?.reloadData()
  }
  
  func isFiltering() -> Bool {
    return searchController.isActive && !searchBarIsEmpty()
  }
  
  private func setUpDisplay() {
    let myCollecetionView = collectionView as? MyCollectionView
    myCollecetionView?.helperView.noResultLabel.isHidden = true
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
  }
}

// MARK: - UISearchResultUpdating Delegate Extension
extension MyCollectionViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
}
