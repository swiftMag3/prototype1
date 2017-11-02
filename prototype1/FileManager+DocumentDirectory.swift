//
//  FileManager+DocumentDirectory.swift
//  prototype1
//
//  Created by Swift Mage on 25/10/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import Foundation

extension FileManager {
  static var documentDirectoryURL: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }
}
