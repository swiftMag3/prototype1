//
//  String+SubAndSup.swift
//  prototype1
//
//  Created by Swift Mage on 08/11/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

extension String {
  
  func customText() -> NSMutableAttributedString {
    let fontSuper:UIFont? = UIFont.systemFont(ofSize: CGFloat(Int(UIFont.systemFontSize / 2)))// UIFont(name: "Helvetica", size:10)
    let font = UIFont.systemFont(ofSize: UIFont.systemFontSize + 4)//UIFont(name: "Helvetica", size: 18)
    let attString:NSMutableAttributedString = NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.font:font])
    var indexA = Array(repeating: 0, count: 10)
    var indexB = Array(repeating: 0, count: 10)
    var indexC = Array(repeating: 0, count: 10)
    var indexD = Array(repeating: 0, count: 10)
    var x = 0
    var z = 0
    var y = 0
    var w = 0
    
    for a in 0..<self.count{
      let index = self.index(self.startIndex, offsetBy: a)
      if self[index] == "{"{
        indexA[x] = a
//        debugPrint(indexA[x])
        x+=1
      }
      if self[index] == "}"{
        indexB[z] = a
//        debugPrint(indexB[z])
        z+=1
      }
      if self[index] == "£"{
        indexC[y] = a
        y+=1
      }
      if self[index] == "$"{
        indexD[w] = a
        w+=1
      }
    }
    
    
    
    for  a in 0..<10{
      if indexA[a] != 0 || indexB[a] != 0 {
        for b in indexA[a]+1..<indexB[a]{
          attString.setAttributes([NSAttributedStringKey.font:fontSuper!,NSAttributedStringKey.baselineOffset:8], range: NSRange(location:b,length:1))
        }
      }
      if indexC[a] != 0 || indexD[a] != 0 {
        for b in indexC[a]+1..<indexD[a]{
          attString.setAttributes([NSAttributedStringKey.font:fontSuper!,NSAttributedStringKey.baselineOffset:-5], range: NSRange(location:b,length:1))
        }
      }
    }
    attString.mutableString.replaceOccurrences(of: "{", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSRange(location: 0, length: attString.length))
    attString.mutableString.replaceOccurrences(of: "}", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSRange(location: 0, length: attString.length))
    attString.mutableString.replaceOccurrences(of: "£", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSRange(location: 0, length: attString.length))
    attString.mutableString.replaceOccurrences(of: "$", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSRange(location: 0, length: attString.length))
    return attString
  }
}
