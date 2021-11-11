//
//  VKAuthorizeViewController.swift
//  SocialWeb
//
//  Created by Никитка on 26.09.2021.
//

import UIKit
import WebKit
import Alamofire

final class VKAuthorizeViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        authorize()
    }
    
    let baseUrl = "https://oauth.vk.com"
    func authorize() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7929153"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68"),
            URLQueryItem(name: "revoke", value: "1")
        ]

        let request = URLRequest(url: urlComponents.url!)

        webView.load(request)
    }
}

extension VKAuthorizeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"],
              let userId = params["user_id"]
        else { return }
        
        MySession.shared.token = token
        MySession.shared.userId = userId
        performSegue(withIdentifier: "toLoginAnimation", sender: self)
        
        decisionHandler(.cancel)
    }
}


