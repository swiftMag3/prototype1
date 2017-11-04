//
//  SectionHeader.swift
//  prototype1
//
//  Created by Swift Mage on 04/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
  @IBOutlet private weak var label: UILabel!
  
  var title: String? {
    didSet {
      label.text = title
    }
  }
}
