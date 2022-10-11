//
//  ViewController.swift
//  InspireVerbier
//
//  Created by Ihor Dolhalov on 09.09.2022.
//

import UIKit
import WebKit
import AppTrackingTransparency


class SecondViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
   
   


    @IBOutlet weak var webView: WKWebView!
  
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var forwardButton: UIButton!
    
    // инициализируем activityIndicator чтоб он появился после кнопки book на время загрузки следующей страницы
    lazy var activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.frame = view.frame
    indicator.backgroundColor = .systemGray6
    return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        
        let url = URL(string: "https://www.inspireverbier.com/timetable")
        let request = URLRequest(url: url!)
        // webView.configuration.preferences.javaScriptEnabled = true
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        webView.allowsBackForwardNavigationGestures = true
  
        // Загружаємо склад сторінки
     
        webView.load(request)
        
        view.addSubview(activityIndicator)
        
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
        
     /*   if #available(iOS 16.0, *) {
            if url.host() == "cart.mindbodyonline.com" { // запустить индикатор при загрузке страницы
                activityIndicator.startAnimating() }
           
        } else {   */
               if url.host == "cart.mindbodyonline.com" { // запустить индикатор при загрузке страницы
               activityIndicator.startAnimating()}
        
        
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
              // Знову перевіряємо чи маємо дозвіл на трекінг, якщо ні - видалити кукіс
        guard #available(iOS 14, *) else { return }
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                  DispatchQueue.main.async {
                      ATTrackingManager.requestTrackingAuthorization {status in
                          switch status {
                              // Проверяем status
                          case .notDetermined:
                              print ("notDetermined")
                          case .restricted:
                              print ("restricted")
                          case .denied:
                              print ("denied")
                              //видалити кукіс і ніколи іх не збирати
                              let javascript = "function waitForElm(e){return new Promise(r=>{if(document.querySelector(e))return r(document.querySelector(e));let o=new MutationObserver(t=>{document.querySelector(e)&&(r(document.querySelector(e)),o.disconnect())});o.observe(document.body,{childList:!0,subtree:!0})})}waitForElm('div[aria-labelledby=cookies_policy_description]').then(e=>{e.remove()});"
                              webView.evaluateJavaScript(javascript) { (result, error) in
                                   print("Код выполнился!")
                              }
                                //request.httpShouldHandleCookies = false
                              HTTPCookieStorage.shared.cookieAcceptPolicy = .never
                          case .authorized:
                              print ("authorized")
                          @unknown default:
                              print ("unknown")
                          }
                      }
                  }
        })

        if activityIndicator.isAnimating { //остановить activityIndicator
             activityIndicator.stopAnimating()
        }
       
       backButton.isEnabled = webView.canGoBack
      forwardButton.isEnabled = webView.canGoForward
          }
    
    
}
