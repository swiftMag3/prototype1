//
//  SameGroupElementCell.swift
//  prototype1
//
//  Created by Swift Mage on 08/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class SameGroupElementCell: UITableViewCell {
  
  @IBOutlet weak var collectionView: GroupCellCollectionView!
  
  func setCollectionViewDataSourceDelegate <D: UICollectionViewDataSource & UICollectionViewDelegate> (dataSourceDelegate: D, forRow row: Int) {
    collectionView.delegate = dataSourceDelegate
    collectionView.dataSource = dataSourceDelegate
    collectionView.tag = row
    collectionView.reloadData()
  }
    
  func reloadCollectionView() {
    collectionView.reloadData()
  }
  
  func updateAppearance(isLoaded: Bool = true) {
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    layout.sectionHeadersPinToVisibleBounds = true
  }
  
}
