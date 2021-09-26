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

    @IBOutlet weak var webView: WKWebView!
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
//        let path = "/authorize"
//        let url = baseUrl + path
//        let parameters: Parameters = [
//            "client_id" : "7929153",
//            "display" : "mobile",
//            "redirect_uri" : "https://oauth.vk.com/blank.html",
//            "scope" : "262150",
//            "respose_type" : "token",
//            "v" : "5.68",
//            "revoke" : "1"
//        ]
//
//        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
//            print(response)
//        }
    }
}
