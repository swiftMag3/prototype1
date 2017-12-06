//
//  DataLoadOperation.swift
//  prototype1
//
//  Created by Swift Mage on 14/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation

class DataLoadOperation: Operation {
//  var element: Element_?
//  var loadingCompleteHandler: ((Element_) -> ())?
//  private let _element: Element_
//
//  init(_ element: Element_) {
//    self._element = element
//  }
//
//  override func main() {
//    if isCancelled { return }
//    self.element = _element
//
//    if let loadingCompleteHandler = loadingCompleteHandler {
//      DispatchQueue.main.async {
//        loadingCompleteHandler(self._element)
//      }
//    }
//  }
  
  var element: ElementRealm?
  var loadingCompleteHandler: ((ElementRealm) -> ())?
  private let _element: ElementRealm
  
  init(_ element: ElementRealm) {
    self._element = element
    super.init()
  }
  
  override func main() {
    if isCancelled { return }
    
    if let loadingCompleteHandler = loadingCompleteHandler {
      DispatchQueue.main.async {
        loadingCompleteHandler(self._element)
      }
    }
  }
  
}
