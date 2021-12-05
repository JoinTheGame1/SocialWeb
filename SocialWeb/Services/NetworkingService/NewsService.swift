//
//  NewsService.swift
//  SocialWeb
//
//  Created by Никитка on 08.11.2021.
//

import Foundation
import Alamofire
import PromiseKit

class NewsService {
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let version = "5.131"
    
    func getNews() -> Promise<News> {
        let method = "/newsfeed.get"

        let parameters: Parameters = [
            "filters": "post, photo",
            "access_token": token,
            "v": version,
            "count": 20,
            "start_from": "next_from"
        ]

        let url = baseUrl + method
        
        return Promise<News> { resolver in
            AF.request(url, method: .get, parameters: parameters).responseJSON { response in
                if let error = response.error {
                    resolver.reject(APIerror.serverError)
                    print(error)
                }
                
                guard let data = response.data else {
                    resolver.reject(APIerror.notData)
                    return
                }
                
                do {
                    let newsResponce = try JSONDecoder().decode(NewsResponce.self, from: data)
                    let news = newsResponce.response
                    resolver.fulfill(news)
                } catch {
                    resolver.reject(APIerror.decodeError)
                }
            }
        }
    }
}
