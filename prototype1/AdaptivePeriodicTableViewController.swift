//
//  AdaptivePeriodicTableViewController.swift
//  prototype1
//
//  Created by Swift Mage on 23/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import RealmSwift


class AdaptivePeriodicTableViewController: UIViewController {
  @IBOutlet weak var mainPeriodicTableView: UIView!
  
  var buttonSubviews = [AdaptiveCellButton]()
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.landscape
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
    return [.all]
  }

  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    populateButtons(inView: mainPeriodicTableView)
    populateLegends(withHelpOf: buttonSubviews.first!, in: mainPeriodicTableView)
    populateOtherViews(withHelpOf: buttonSubviews.first!, in: mainPeriodicTableView)
  }
  
  @objc func selectAnElement(sender: AdaptiveCellButton) {
    performSegue(withIdentifier: "goToElement", sender: sender)
  }
  
  private func populateButtons(inView containerView: UIView) {
    if !buttonSubviews.isEmpty {
      for button in buttonSubviews {
        button.removeFromSuperview()
      }
    }

    for index in 1...118 {
      let button = AdaptiveCellButton()
      button.setupButton(for: index, withPercentageFor: .normal, inView: containerView)
      button.addTarget(self, action: #selector(selectAnElement(sender:)), for: .touchUpInside)
      button.isExclusiveTouch = true
      
      containerView.addSubview(button)
      buttonSubviews.append(button)
    }
  }
  
  private func populateLegends(withHelpOf firstButton: AdaptiveCellButton, in containerView: UIView) {
    let width = Int(firstButton.frame.width)
    let margin =  Int(firstButton.frame.origin.x) //(Int(view.frame.width) - (width * 18)) / 2
    print(margin)
    for index in 0..<18 {
      let x = margin + index * width
      let groupLabel = UILabel(frame: CGRect(x: x, y: 5, width: width, height: 15))
      switch (index+1) {
      case 1:
        groupLabel.text = "IA"
      case 2:
        groupLabel.text = "IIA"
      case 3:
        groupLabel.text = "IIIB"
      case 4:
        groupLabel.text = "IVB"
      case 5:
        groupLabel.text = "VB"
      case 6:
        groupLabel.text = "VIB"
      case 7:
        groupLabel.text = "VIIB"
      case 9:
        groupLabel.text = "VIIIB"
      case 11:
        groupLabel.text = "IB"
      case 12:
        groupLabel.text = "IIB"
      case 13:
        groupLabel.text = "IIIA"
      case 14:
        groupLabel.text = "IVA"
      case 15:
        groupLabel.text = "VA"
      case 16:
        groupLabel.text = "VIA"
      case 17:
        groupLabel.text = "VIIA"
      case 18:
        groupLabel.text = "VIIIA"
      default:
        groupLabel.text = ""
      }
      groupLabel.textAlignment = .center
      groupLabel.font = UIFont.systemFont(ofSize: 12)
      groupLabel.adjustsFontSizeToFitWidth = true
      containerView.addSubview(groupLabel)
    }
    
    //first 5 legends
    for index in 0..<5 {
      let legendHeight = (3*width-2)/5
      let legendWidth = 125

      let x = margin + 20 + 2 * width
      let y = 30 + index * legendHeight
      //legend box
      let legendBox = UIView(frame: CGRect(x: x, y: y, width: legendHeight, height: legendHeight))
      legendBox.layer.cornerRadius = CGFloat(legendHeight)
      legendBox.layer.borderColor = UIColor.lightGray.cgColor
      legendBox.layer.borderWidth = 0.5
      
      //legend label
      let legendLabel = UILabel(frame: CGRect(x: x + legendHeight + 2, y: y, width: legendWidth, height: legendHeight))
      legendLabel.adjustsFontSizeToFitWidth = true
      legendLabel.textColor = UIColor.flatBlack()
      legendLabel.font = UIFont.systemFont(ofSize: 10)
      legendLabel.layer.cornerRadius = 8
      legendLabel.clipsToBounds = true
      
      switch index {
      case 0:
        legendLabel.text = "Alkali Metals".localize(withComment: "legend string")
        legendBox.backgroundColor = Cache.alkaliMetalsColor
      case 1:
        legendLabel.text = "Alkaline Earth Metals".localize(withComment: "legend string")
        legendBox.backgroundColor = Cache.alkalineEarthMetalsColor
      case 2:
        legendLabel.text = "Transition Metals".localize(withComment: "legend string")
        legendBox.backgroundColor = Cache.transitionMetalsColor
      case 3:
        legendLabel.text = "Post-transition Metals".localize(withComment: "legend string")
        legendBox.backgroundColor = Cache.postTransitionMetalColor
      case 4:
        legendLabel.text = "Metalloids".localize(withComment: "legend string")
        legendBox.backgroundColor = Cache.metalloidsColor
      default:
        break
      }
      containerView.addSubview(legendBox)
      containerView.addSubview(legendLabel)
    }
    // next 5 legends
    for index in 0..<5 {
      let legendHeight = (3*width-2)/5
      let legendWidth = 125
      
      let x = margin + 22 + legendWidth + legendHeight + 2 * width
      let y = 30 + index * legendHeight
      // legend box
      let legendBox = UIView(frame: CGRect(x: x, y: y, width: legendHeight, height: legendHeight))
      legendBox.layer.cornerRadius = CGFloat(legendHeight)
      legendBox.layer.borderColor = UIColor.lightGray.cgColor
      legendBox.layer.borderWidth = 0.5

      // legend labrl
      let legendLabel = UILabel(frame: CGRect(x: x + legendHeight + 2, y: y, width: legendWidth, height: legendHeight))
      legendLabel.adjustsFontSizeToFitWidth = true
      legendLabel.textColor = UIColor.flatBlack()
      legendLabel.font = UIFont.systemFont(ofSize: 10)
      legendLabel.layer.cornerRadius = 8
      legendLabel.clipsToBounds = true
      
      switch index {
      case 0:
        legendLabel.text = "Non-metals".localize(withComment: "legend string")
        legendBox.backgroundColor = Cache.otherNonMetalsColor
      case 1:
        legendLabel.text = "Noble Gases".localize(withComment: "legend string")
        legendBox.backgroundColor = Cache.nobleGasesColor
      case 2:
        legendLabel.text = "Lanthanoids".localize(withComment: "legend string")
        legendBox.backgroundColor = Cache.lanthanoidsColor
      case 3:
        legendLabel.text = "Actinoids".localize(withComment: "legend string")
        legendBox.backgroundColor = Cache.actinoidsColor
      case 4:
        legendLabel.text = UnknownValue.string
        legendBox.backgroundColor = Cache.unknownColor
      default:
        break
      }
      
      containerView.addSubview(legendBox)
      containerView.addSubview(legendLabel)
    }
  }
  
  private func populateOtherViews(withHelpOf firstButton: AdaptiveCellButton, in containerView: UIView) {
    let width = Int(firstButton.frame.width)
    let margin = Int(firstButton.frame.origin.x)
    let x = margin + 11 * width
    let y = 25
    let titleLabel = UILabel(frame: CGRect(x: x, y: y, width: width*6, height: width))
    titleLabel.text = "XXxxXXXXXXXX"
    containerView.addSubview(titleLabel)
  }
  
  
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "goToElement", let sender = sender as? AdaptiveCellButton else { return }
    let navController = segue.destination as? UINavigationController
    let homeVC = navController?.viewControllers.first as? MyCollectionViewController
    homeVC?.performSegue(withIdentifier: "ShowDetail", sender: try! Realm().objects(ElementRealm.self)[sender.atomicNumber-1])
  }

  
}
