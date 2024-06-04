// 
// SPDX-FileCopyrightText: 2024 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import Foundation
import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webViewProvider: WKWebView!
    
    var provider: Provider?
    var spidDelegate: SpidDelegate?
    var spidConfig: SpidConfig?
    var timeout: Int!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webViewProvider.navigationDelegate = self
        timeout = spidConfig?.timeout
        
        if let provider = provider,
           let authPageUrl = spidConfig?.authPageUrl {
            
            // Creation of the request for the selected provider
            var urlString = "\(authPageUrl)\(provider.idp)"
            
            if let queryStringParams = spidConfig?.queryStringParams {
                urlString += queryStringParams
            }
            guard let url = URL(string:urlString) else {
                self.dismiss(animated: true, completion: {
                    self.spidDelegate?.onError(error: .UrlNotWorking(url: urlString))
                })
                return
            }
            
            let request = URLRequest(url: url)
            webViewProvider.load(request)
            
            initTimer()
        }
        
    }
    
    static func instance() -> LoginViewController? {
        let storyboard = UIStoryboard(name: "Login", bundle: .module)
        let loginViewController = storyboard.instantiateInitialViewController() as? LoginViewController
        return loginViewController
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.timer?.invalidate()
        self.timer = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let loadedUrlString = webView.url?.absoluteString,
           let callbackPageUrl = self.spidConfig?.callbackPageUrl {
            // When the loaded url equals the url passed in settings,
            // the cookies are passed through the protocol
            if (loadedUrlString == callbackPageUrl) {
                let cookies = WKWebsiteDataStore.default().httpCookieStore
                cookies.getAllCookies { cookies in
                    self.dismiss(animated: true, completion: { [weak self] in
                        self?.timer?.invalidate()
                        self?.timer = nil
                        let responseObj = SpidResponse.init(cookies: cookies)
                        self?.spidDelegate?.loginSuccess(response: responseObj)
                    })
                }
            } else {
                self.resetTimer()
            }
        }
    }
    
    // MARK: - Timeout settings
    
    @objc func startTimer(){
        if timeout == 0 {
            self.timer?.invalidate()
            self.timer = nil
            self.dismiss(animated: true, completion: {
                self.spidDelegate?.onError(error: .Timeout)
            })
        } else {
            timeout -= 1
        }
    }
    
    func initTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }
    
    func resetTimer(){
        timeout = spidConfig?.timeout
    }
}
