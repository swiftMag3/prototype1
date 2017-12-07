//
//  PeriodicTableViewController.swift
//  prototype1
//
//  Created by Swift Mage on 06/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import RealmSwift

class PeriodicTableViewController: UIViewController {

  @IBOutlet weak var homeButton: UIButton!
  
  private var helperBox = UIView()
  override var prefersStatusBarHidden: Bool {
    return true
  }

  @IBAction func dismissViewController(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populateButton()
    homeButton.transform = CGAffineTransform(rotationAngle:  -CGFloat.pi/2)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "TableToHome", let sender = sender as? CellButton else { return }
    let navController = segue.destination as? UINavigationController
    let homeVC = navController?.viewControllers.first as? MyCollectionViewController
    homeVC?.performSegue(withIdentifier: "ShowDetail", sender: try! Realm().objects(ElementRealm.self)[sender.atomicNumber-1])
  }
  
  func populateButton() {
    for index in 1...118 {
      let button = CellButton(atomicNumber: index)
      button.setupButton()
      button.addTarget(self, action: #selector(touchDownEvent(sender:)), for: .touchDown)
      button.addTarget(self, action: #selector(selectAnElement(sender:)), for: .touchUpInside)
      button.addTarget(self, action: #selector(cancelTouchEvent(sender:)), for: .touchDragExit)
      
      self.view.addSubview(button)
    }
  }
  
  @objc func selectAnElement(sender: CellButton) {
    helperBox.removeFromSuperview()
    UIView.animate(withDuration: 0.5) {
      self.homeButton.alpha = 1
    }
    performSegue(withIdentifier: "TableToHome", sender: sender)
  }
  
  @objc func touchDownEvent(sender: CellButton) {
    let elementInfo = getElementInfo(for: sender.atomicNumber)
    homeButton.alpha = 0
    
    // Helper Box - UIView
    helperBox = UIView(frame: CGRect(x: 288, y: 570, width: 80, height: 80))
    helperBox.layer.cornerRadius = 15
    helperBox.backgroundColor = UIColor(hex: elementInfo.cpkColor)
    self.view.addSubview(helperBox)
    
    // Filter View - UIView
    let filterView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    filterView.backgroundColor = UIColor(red: 0.847, green: 0.875, blue: 0.918, alpha: 0.4)
    helperBox.addSubview(filterView)
    
    // Name Label
    let nameLabel = UILabel(frame: CGRect(x: 7, y: 52, width: 67, height: 19))
    nameLabel.text = elementInfo.name
    nameLabel.adjustsFontSizeToFitWidth = true
    nameLabel.textAlignment = .center
    nameLabel.textColor = UIColor.adjustColor(textColor: .black, withBackground: helperBox.backgroundColor!)
    helperBox.addSubview(nameLabel)
    
    // Atomic Number Label
    let atomicNumberLabel = UILabel(frame: CGRect(x: 7, y: 6, width: 50, height: 21))
    atomicNumberLabel.text = String(sender.atomicNumber)
    atomicNumberLabel.font = UIFont.systemFont(ofSize: 15)
    atomicNumberLabel.textAlignment = .left
    atomicNumberLabel.textColor = UIColor.adjustColor(textColor: .black, withBackground: helperBox.backgroundColor!)
    helperBox.addSubview(atomicNumberLabel)
    
    
    // Symbol Label
    let symbolLabel = UILabel(frame:CGRect(x: 7, y: 25, width: 67, height: 30))
    symbolLabel.text = elementInfo.symbol
    symbolLabel.font = UIFont.boldSystemFont(ofSize: 25)
    symbolLabel.textAlignment = .center
    symbolLabel.textColor = UIColor.adjustColor(textColor: .black, withBackground: helperBox.backgroundColor!)
    
    // Shadowlayer
    let shadowLayer = CAShapeLayer()
    shadowLayer.path = UIBezierPath(roundedRect: helperBox.bounds, cornerRadius: 15).cgPath
    shadowLayer.fillColor = helperBox.backgroundColor?.cgColor
    
    shadowLayer.shadowColor = UIColor.darkGray.cgColor
    shadowLayer.shadowPath = shadowLayer.path
    shadowLayer.shadowOffset = CGSize(width: 0, height: 5)
    shadowLayer.shadowOpacity = 0.5
    shadowLayer.shadowRadius = 10
    helperBox.layer.insertSublayer(shadowLayer, at: 0)
    
    helperBox.addSubview(symbolLabel)
    helperBox.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
  }
  
  @objc func cancelTouchEvent(sender: CellButton) {
    helperBox.removeFromSuperview()
    UIView.animate(withDuration: 0.5) {
      self.homeButton.alpha = 1
    }
  }
  
  func getElementInfo(for atomicNumber: Int) -> (symbol: String, cpkColor: String, name: String) {
    let element = try! Realm().objects(ElementRealm.self)[atomicNumber-1]
    return (symbol: element.symbol, cpkColor: element.cpkHexColor, name: element.localizedName)
  }
}
