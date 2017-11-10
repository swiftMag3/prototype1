//
//  MyCollectionViewCell.swift
//  prototype1
//
//  Created by Swift Mage on 01/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var atomicNumberLabel: UILabel!
  @IBOutlet weak var atomicMassLabel: UILabel!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  
  var element: ElementIcon?
  
  override func prepareForReuse() {
    label.text = ""
  }
  
 
  func updateAppearanceFor(_ element: ElementIcon?, animated: Bool = true) {
    DispatchQueue.main.async {
      if animated {
        UIView.animate(withDuration: 0.5) {
          self.displayElement(element)
        }
      } else {
        self.displayElement(element)
      }
    }
  }
  
  private func displayElement(_ element: ElementIcon?) {
    self.element = element
    
    if let element = element {

//      let cpkColor: String?
//      if isFiltering {
//        element = filteredElements[indexPath.row]
//      } else {
//        let groupName = groupTitles[indexPath.section]
//        if let elementsGrouped = groupDictionary[groupName] {
//          elementIconData = elementsGrouped[indexPath.row]
//        }
//        noResultLabel.isHidden = true
//      }
//      cpkColor = elementIconData.cpkColor
//      cell.label.text = elementIconData.elementSymbol
//      cell.atomicMassLabel.text = String(format: "%.0f", elementIconData.atomicMass)
//      cell.atomicNumberLabel.text =  "\(elementIconData.atomicNumber)"
//      cell.backgroundColor = UIColor(hex: cpkColor ?? "ffffff")
//      cell.label.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
//      cell.atomicMassLabel.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
//      cell.atomicNumberLabel.textColor = UIColor.adjustColor(textColor: UIColor.black, withBackground: cell.backgroundColor!)
//      // corner radius
//      let width = (view.frame.size.width - 60) / 5
//      cell.layer.cornerRadius = CGFloat(Int(width / 4))
//      cell.layer.masksToBounds = true

      label.text = element.elementSymbol
      loadingIndicator?.alpha = 0
      loadingIndicator?.stopAnimating()
    } else {
      loadingIndicator?.alpha = 1.0
      loadingIndicator?.startAnimating()
    }
    
  }
  /*
   /*
   var elementIconData = ElementIcon()
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
   
   return cell */
 */
 
  
}
