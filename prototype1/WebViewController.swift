//
//  WebViewController.swift
//  prototype1
//
//  Created by Swift Mage on 12/12/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  @IBOutlet var webView: WKWebView!
  
  var targetURL = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let url = Bundle.main.url(forResource: "Licenses", withExtension: "html") {
      if let htmlData = try? Data(contentsOf: url) {
        let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
        webView.load(htmlData, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: baseURL)
      }
    }
    
    navigationItem.largeTitleDisplayMode = .never
    
    if let url = URL(string: targetURL) {
      let request = URLRequest(url: url)
      webView.load(request)
    }
    
    // Do any additional setup after loading the view.
  }
  

  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension WebViewController: UIWebViewDelegate {
  func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    if navigationType == UIWebViewNavigationType.linkClicked {
      UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)
      print("safari opened?")
    }
    return true
  }
}
