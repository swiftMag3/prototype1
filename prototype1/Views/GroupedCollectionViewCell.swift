//
//  GroupedCollectionViewCell.swift
//  prototype1
//
//  Created by Swift Mage on 08/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class GroupedCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var elementLabel: UILabel!
  
  override func prepareForReuse() {
    elementLabel.text = ""
  }
}
