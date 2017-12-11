//
//  PeriodicTableViewController.swift
//  prototype1
//
//  Created by Swift Mage on 06/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import RealmSwift
import Chameleon

class PeriodicTableViewController: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var backgroundView: PeriodicTableBackgroundView!
  @IBOutlet weak var homeButton: UIButton!
  @IBOutlet weak var homeLabel: UILabel!
  @IBOutlet weak var comparisonTitle: UILabel!
  private var trendHelperBox: UIView = UIView()
  private var buttonSubviews: [CellButton] = []
  private var helperBox = UIView()
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  @IBAction func densityComparison(_ sender: UIButton) {
    self.populateButton(for: .density)
  }
  @IBAction func boilingPointComparison(_ sender: UIButton) {
    self.populateButton(for: .boilingPoint)
  }
  @IBAction func meltingPointComparison(_ sender: Any) {
    self.populateButton(for: .meltingPoint)
  }
  @IBAction func electronegativityComparison(_ sender: UIButton) {
    self.populateButton(for: .electronegativity)
  }
  @IBAction func ionizationComparison(_ sender: UIButton) {
    self.populateButton(for: .ionization)
  }
  @IBAction func radiusComparison(_ sender: UIButton) {
    self.populateButton(for: .density)
  }
  
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.landscape
  }
  
  @IBAction func homeButtonAction(_ sender: Any) {
    
    let alert = UIAlertController(title: "Comparison".localize(withComment: "periodic table alert"), message: nil, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "Default".localize(withComment: "periodic table alert"), style: .default) { (_) in
      self.populateButton()
    }
    
    let densityComparisonAction = UIAlertAction(title: "Density Comparison".localize(withComment: "periodic table alert"), style: .default) { (_) in
      self.populateButton(for: .density)
    }
    
    let radiusComparisonAction = UIAlertAction(title: "Radius Comparison".localize(withComment: "periodic table alert"), style: .default) { (_) in
      self.populateButton(for: .atomicRadius)
    }
    
    let electronegativityComparisonAction = UIAlertAction(title: "Electronegativity Comparison".localize(withComment: "periodic table alert"), style: .default) { (_) in
      self.populateButton(for: .electronegativity)
    }
    
    let meltingPointComparisonAction = UIAlertAction(title: "Melting Point Comparison".localize(withComment: "periodic table alert"), style: .default) { (_) in
      self.populateButton(for: .meltingPoint)
    }
    
    let boilingPointComparisonAction = UIAlertAction(title: "Boiling Point Comparison".localize(withComment: "periodic table alert"), style: .default) { (_) in
      self.populateButton(for: .boilingPoint)
    }
    
    let ionizationComparisonAction = UIAlertAction(title: "Ionization Comparison".localize(withComment: "periodic table alert"), style: .default) { (_) in
      self.populateButton(for: .ionization)
    }
    
    
    alert.addAction(defaultAction)
    alert.addAction(densityComparisonAction)
    alert.addAction(radiusComparisonAction)
    alert.addAction(electronegativityComparisonAction)
    alert.addAction(meltingPointComparisonAction)
    alert.addAction(boilingPointComparisonAction)
    alert.addAction(ionizationComparisonAction)

    present(alert, animated: true)
  }
  
  override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
    return [.all]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    populateButton(for: .normal)
    setCloseButton()
    homeButton.setTitle("MENU", for: .normal)
  }
    
  @objc func reset() {
    populateButton()
  }
  
//  private func setBackgroundForSmallerDevice() {
//    if view.frame.width <= 667 {
//      iphone5BackgroundView.isHidden = false
//    }
//    iphone5BackgroundView.isHidden = true
//  }
  
  
  //To return from landscape to portrait orientation for show-segue
//  override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//    if self.isMovingFromParentViewController {
//      UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
//    }
//  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "TableToHome", let sender = sender as? CellButton else { return }
    let navController = segue.destination as? UINavigationController
    let homeVC = navController?.viewControllers.first as? MyCollectionViewController
    homeVC?.performSegue(withIdentifier: "ShowDetail", sender: try! Realm().objects(ElementRealm.self)[sender.atomicNumber-1])
  }
  
  func populateButton(for displayType: DisplayType = DisplayType.normal) {
    // clear the button subviews before adding new ones
    if !buttonSubviews.isEmpty {
      for button in buttonSubviews {
        button.removeFromSuperview()
      }
    }
    
    switch displayType {
    case .normal:
      comparisonTitle.isHidden = true
    case .atomicRadius:
      comparisonTitle.isHidden = false
      comparisonTitle.text = "Atomic Radius Comparison".localize(withComment: "Title for comparison")
    case .boilingPoint:
      comparisonTitle.isHidden = false
      comparisonTitle.text = "Boiling Point Comparison".localize(withComment: "Title for comparison")
    case .density:
      comparisonTitle.isHidden = false
      comparisonTitle.text = "Density Comparison".localize(withComment: "Title for comparison")
    case .electronegativity:
      comparisonTitle.isHidden = false
      comparisonTitle.text = "Electronegativity Comparison".localize(withComment: "Title for comparison")
    case .ionization:
      comparisonTitle.isHidden = false
      comparisonTitle.text = "Ionization Energy".localize(withComment: "Title for comparison")
    case .meltingPoint:
      comparisonTitle.isHidden = false
      comparisonTitle.text = "Melting Point Comparison".localize(withComment: "Title for comparison")
    }
    
    
    // start adding new button subviews
    for index in 1...118 {
      let button = CellButton()
      button.setupButton(for: index, withPercentageFor: displayType)
      button.addTarget(self, action: #selector(touchDownEvent(sender:)), for: .touchDown)
      button.addTarget(self, action: #selector(selectAnElement(sender:)), for: .touchUpInside)
      button.addTarget(self, action: #selector(cancelTouchEvent(sender:)), for: .touchDragExit)
      button.isExclusiveTouch = true

      self.backgroundView.addSubview(button)
      buttonSubviews.append(button)
    }
  }
  
  func setCloseButton() {
    let closeButton = UIButton(frame: CGRect(x: 0, y: 5, width: 30, height: 30))
    closeButton.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
    closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    view.addSubview(closeButton)
    if view.frame.width >= 414 {
      homeButton.isHidden = true
      homeLabel.isHidden = true
      let resetButton = UIButton(frame: CGRect(x: 36, y: 315, width: 50, height: 50))
      resetButton.setTitle("RESET".localize(withComment: "Home button label"), for: .normal)
      resetButton.titleLabel?.adjustsFontSizeToFitWidth = true
      resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
      resetButton.backgroundColor = UIColor.flatBlue()
      resetButton.setTitleColor(UIColor.init(contrastingBlackOrWhiteColorOn: resetButton.backgroundColor, isFlat: true), for: .normal)
      resetButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)
      resetButton.layer.cornerRadius = 5
      self.view.addSubview(resetButton)
    }
  }
  
  @objc func dismissViewController() {
    self.dismiss(animated: true) {
      // return from landscape to portrait again for present-modally-segue
      UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
    }
  }
  
  @objc func selectAnElement(sender: CellButton) {
    helperBox.removeFromSuperview()
    self.homeButton.alpha = 1
    performSegue(withIdentifier: "TableToHome", sender: sender)
  }
  
  @objc func touchDownEvent(sender: CellButton) {
    let elementInfo = getElementInfo(for: sender.atomicNumber)

    
    // Floating Helper Box - UIView
    helperBox = UIView(frame: CGRect(x: 17, y: 290, width: 80, height: 80))
    helperBox.layer.cornerRadius = 15
    helperBox.backgroundColor = UIColor(hex: elementInfo.cpkColor).add(overlay: UIColor(hex: "E1E6E5").withAlphaComponent(0.5))
    
    if view.frame.width > 568 {
      homeButton.alpha = 0
      self.backgroundView.addSubview(helperBox)
      
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
    }
    
  }
  
  @objc func cancelTouchEvent(sender: CellButton) {
    helperBox.removeFromSuperview()
    UIView.animate(withDuration: 0.5) {
      self.homeButton.alpha = 1
    }
  }
  
  private func getElementInfo(for atomicNumber: Int) -> (symbol: String, cpkColor: String, name: String) {
    let element = try! Realm().objects(ElementRealm.self)[atomicNumber-1]
    return (symbol: element.symbol, cpkColor: element.cpkHexColor, name: element.localizedName)
  }
}


extension PeriodicTableBackground {
  
}
