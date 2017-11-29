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
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setCollectionViewDataSourceDelegate <D: UICollectionViewDataSource & UICollectionViewDelegate> (dataSourceDelegate: D, forRow row: Int) {
    collectionView.delegate = dataSourceDelegate
    collectionView.dataSource = dataSourceDelegate
    collectionView.tag = row
    collectionView.reloadData()
  }
    
  func reloadCollectionView() {
    collectionView.reloadData()
  }
  
  func updateAppearance(isLoaded: Bool) {
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    layout.sectionHeadersPinToVisibleBounds = true
    if isLoaded {
      loadingIndicator.isHidden = true
      loadingIndicator.stopAnimating()
    } else {
      loadingIndicator.isHidden = false
      loadingIndicator.startAnimating()
    }
  }
  
}
