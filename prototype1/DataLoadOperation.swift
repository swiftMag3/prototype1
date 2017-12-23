//
//  DataLoadOperation.swift
//  prototype1
//
//  Created by Swift Mage on 14/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation

class DataLoadOperation: Operation {  
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
