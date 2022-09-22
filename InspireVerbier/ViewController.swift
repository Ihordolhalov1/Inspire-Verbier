//
//  ViewController.swift
//  InspireVerbier
//
//  Created by Ihor Dolhalov on 09.09.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
   
    

    @IBOutlet weak var webView: WKWebView!
  
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var forwardButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        
        webView.navigationDelegate = self
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        
        let url = URL(string: "https://www.inspireverbier.com/timetable")
        //let url = URL(string: "https://www.apple.com")
        let request = URLRequest(url: url!)
        //webView.configuration.preferences.javaScriptEnabled = true
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        webView.allowsBackForwardNavigationGestures = true
        webView.load(request)
        if webView.canGoBack == false {
            backButton.isEnabled = false} else { backButton.isEnabled = true }
        if webView.canGoForward == false {
            forwardButton.isEnabled = false} else { forwardButton.isEnabled = true }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                
        if webView.canGoBack == false {
            backButton.isEnabled = false} else { backButton.isEnabled = true }
        if webView.canGoForward == false {
            forwardButton.isEnabled = false} else { forwardButton.isEnabled = true }
        
        guard
        let url = navigationAction.request.url,
        let scheme = url.scheme else {
        decisionHandler (. cancel)
        return
        }
        
        if (scheme.lowercased() == "mailto") {
        UIApplication.shared.open (url, options: [:],
        completionHandler: nil)
        // here I decide to •cancel, do as you wish
        decisionHandler(.cancel)
        return
        }
     
        if (scheme.lowercased() == "tel") {
        UIApplication.shared.open (url, options: [:],
        completionHandler: nil)
        // here I decide to •cancel, do as you wish
        decisionHandler(.cancel)
        return
        }
        
        if (scheme.lowercased() == "facebook") {
        UIApplication.shared.open (url, options: [:],
        completionHandler: nil)
        // here I decide to •cancel, do as you wish
        decisionHandler(.cancel)
        return
        }
        
        if (scheme.lowercased() == "instagram") {
        UIApplication.shared.open (url, options: [:],
        completionHandler: nil)
        // here I decide to •cancel, do as you wish
        decisionHandler(.cancel)
        return
        }
        
        decisionHandler(.allow)
    }

    
   
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
                    webView.load(navigationAction.request)
                    }
                    return nil
    }


    @IBAction func backAction(_ sender: UIButton) {
        if webView.canGoBack {
            backButton.isEnabled = true
            webView.goBack()
        }
    }
    
    @IBAction func forwardAction(_ sender: UIButton) {
        if webView.canGoForward {
            forwardButton.isEnabled = true
            webView.goForward()}
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       backButton.isEnabled = webView.canGoBack
      forwardButton.isEnabled = webView.canGoForward
          

        
   }
}
