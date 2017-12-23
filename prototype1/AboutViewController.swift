//
//  AboutViewController.swift
//  prototype1
//
//  Created by Swift Mage on 12/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import MessageUI
import Chameleon

class AboutViewController: UITableViewController {
  
  private var sectionTitles = ["Feedback", "Other Info"]
  private var sectionContent = [[(image: #imageLiteral(resourceName: "ratingIcon"), text: "Rate this app on App Store", link: "itms-apps:itunes.apple.com/app/id-here"), (image: #imageLiteral(resourceName: "FeedbackIcon"),text: "Tell us your feedback", link: "mailto:swiftmag3@gmail.com")], [(image: #imageLiteral(resourceName: "LicenseIcon"),text: "Licenses", link: "aa")]]
  
  func sendEmail() {
    if MFMailComposeViewController.canSendMail() {
      let mail = MFMailComposeViewController()
      mail.mailComposeDelegate = self
      mail.setToRecipients(["swiftmag3@gmail.com"])
      mail.setSubject("Hello!")
      mail.setMessageBody("Hello!", isHTML: true)
      present(mail, animated: true)
    } else {
      let alert = UIAlertController(title: "Error".localize(withComment: "alert controller title"), message: "Can not send mail".localize(withComment: "message for alert controller"), preferredStyle: .alert)
      let action = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
        alert.dismiss(animated: true)
      })
      alert.addAction(action)
      present(alert, animated: true)
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.cellLayoutMarginsFollowReadableWidth = true
    tableView.tableFooterView = UIView()
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
//    let customFont = UIFont.systemFont(ofSize: 40)
//    navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: customFont]
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return sectionTitles.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return sectionContent[section].count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionTitles[section]
  }
  
  
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath)
   
   let cellData = sectionContent[indexPath.section][indexPath.row]
    cell.textLabel?.text = cellData.text
    cell.imageView?.image = cellData.image
   return cell
   }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let link = sectionContent[indexPath.section][indexPath.row].link
    
    switch indexPath.section {
    case 0:
      if indexPath.row == 0 {
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      } else if indexPath.row == 1 {
        sendEmail()
      }
    case 1:
      if indexPath.row == 0 {
        performSegue(withIdentifier: "showWebView", sender: self)
      }
    default:
      break
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "showWebView" {
//      if let webViewController = segue.destination as? WebViewController, let indexPath = tableView.indexPathForSelectedRow {
//        webViewController.targetURL = sectionContent[indexPath.section][indexPath.row].link
//
//      }
//    }
//  }
  
  
}
// MARK: - Mail Compose Controller Delegate
extension AboutViewController: MFMailComposeViewControllerDelegate {
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
  
}
