//
//  CopyableUILabel.swift
//  prototype1
//
//  Created by Swift Mage on 08/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import Foundation

class CopyableUILabel: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  // Enable interaction
  func sharedInit() {
    isUserInteractionEnabled = true
    addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenu)))
  }
  // First responder set up
  override var canBecomeFirstResponder: Bool {
    return true
  }
  // Copy method
  override func copy(_ sender: Any?) {
    let board = UIPasteboard.general
    board.string = text
    let menu = UIMenuController.shared
    menu.setMenuVisible(false, animated: true)
  }
  // Showing the menu after long press
  @objc func showMenu(sender: Any?) {
    becomeFirstResponder()
    let menu = UIMenuController.shared
    if !menu.isMenuVisible {
      menu.setTargetRect(bounds, in: self)
      menu.setMenuVisible(true, animated: true)
    }
  }
  // Enable label to perform action
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if action == #selector(copy(_:)) {
      return true
    }
    return false
  }
  
}
