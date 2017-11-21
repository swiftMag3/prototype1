//
//  FilteringOperation.swift
//  prototype1
//
//  Created by Swift Mage on 17/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class FilteringOperation: AsyncOperation {
  var theElement: Element_?
  var inputElements: [Element_]?
  var outputElementsForGroup: [Element_]?
  var outputElementsForPeriod: [Element_]?
  
  init(inputElements: [Element_]?, with element: Element_?) {
    self.inputElements = inputElements
    self.theElement = element
  }
  
  override func main() {
    if isCancelled { return }
    DispatchQueue.global().async {
      guard let inputElements = self.inputElements , let theElement = self.theElement else { return }
      for element in inputElements {
        if self.isCancelled { return }
        if element.elementPosition.column == theElement.elementPosition.column && element.symbol != theElement.symbol {
          self.outputElementsForGroup?.append(element)
        }
      }
      for element in inputElements {
        if self.isCancelled { return }
        if element.elementPosition.row == theElement.elementPosition.row && element.symbol != theElement.symbol {
          self.outputElementsForPeriod?.append(element)
        }
      }
    }
  }
}


class FilteringBlockOperation: BlockOperation {
  var state: Bool = false
  override func cancel() {
    state = false
  }
  
  override var isCancelled: Bool {
    return state
  }
}
