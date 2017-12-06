//
//  FilteringOperation.swift
//  prototype1
//
//  Created by Swift Mage on 17/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import RealmSwift

class FilteringOperation: Operation {
  var element: ElementRealm?
  var loadingCompletionHandler: ((Results<ElementRealm>) -> Void)?// TODO
//  var filteringTask: ((Element_) -> Void)? //TODO
  var indexPath: IndexPath
  var elementsFiltered: Results<ElementRealm>?
  
  init(element: ElementRealm, indexPath: IndexPath) {
    self.element = element
    self.indexPath = indexPath
  }
  
  private func filter(completion: ((Results<ElementRealm>) -> Void)? ) {
    if isCancelled { return }
    let allElements = try! Realm().objects(ElementRealm.self)
    var elements: Results<ElementRealm>
    guard let theElement = element else { return }
    if indexPath.row == 23 {
      if isCancelled { return }

      elements = allElements.filter("elementColumn = \(theElement.elementColumn) AND atomicNumber != \(theElement.atomicNumber)")
    } else {
      if isCancelled { return }

      elements = allElements.filter("elementRow = \(theElement.elementRow) AND atomicNumber != \(theElement.atomicNumber)")
    }
    elementsFiltered = elements
    completion?(elements)
  }
  
  override func main() {
    
    // Edit here
    if isCancelled { return }
    filter { (elements) in
      if let loadingCompletionHandler = self.loadingCompletionHandler {
        DispatchQueue.main.async {
          loadingCompletionHandler(elements)
        }
      }
    }
    
    
    
    
    /*
     if isCancelled { return }
     self.element = theElement
     
     if let filteringTask = filteringTask /*, let loadingCompleteHandler = loadingCompleteHandler*/ {
     //DispatchQueue.global(qos: .utility).async {
     if isCancelled { return }
     filteringTask(self.theElement)
     //        DispatchQueue.main.async {
     //          loadingCompleteHandler(self.theElement)
     //        }
     
     //}
     }
     */
  }
}


//class FilteringBlockOperation: BlockOperation {
//  var state: Bool = false
//  override func cancel() {
//    state = false
//  }
//
//  override var isCancelled: Bool {
//    return state
//  }
//}

