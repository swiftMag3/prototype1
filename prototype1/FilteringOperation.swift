//
//  FilteringOperation.swift
//  prototype1
//
//  Created by Swift Mage on 17/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class FilteringOperation: Operation {
  var element: Element_?
  var loadingCompletionHandler: (([Element_]) -> Void)?// TODO
//  var filteringTask: ((Element_) -> Void)? //TODO
  var indexPath: IndexPath
  var elementsFiltered: [Element_]?
  
  init(element: Element_, indexPath: IndexPath) {
    self.element = element
    self.indexPath = indexPath
  }
  
  private func filter(completion: (([Element_]) -> Void)? ) {
    if isCancelled { return }
    let allElements = ElementsDataSource().allElements
    var elements: [Element_]
    guard let theElement = element else { return }
    if indexPath.row == 23 {
      if isCancelled { return }

      elements = allElements.filter({ (element) -> Bool in
        element.elementPosition.column == theElement.elementPosition.column
      })
      elements.remove(at: elements.index(of: theElement)!)
    } else {
      if isCancelled { return }

      elements = allElements.filter({ (element) -> Bool in
        element.elementPosition.row == theElement.elementPosition.row
      })
      elements.remove(at: elements.index(of: theElement)!)
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

