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
    
    func getDataNews(_ nextFrom: String = "next_from") -> Promise<Data> {
        let method = "/newsfeed.get"

        let parameters: Parameters = [
            "filters": "post, photo",
            "access_token": token,
            "v": version,
            "count": 20,
            "start_from": nextFrom
        ]

        let url = baseUrl + method
        
        return Promise { resolver in
            AF.request(url, method: .get, parameters: parameters).responseJSON { response in
                if let error = response.error {
                    resolver.reject(APIerror.serverError)
                    print(error)
                }
                guard let data = response.data else {
                    resolver.reject(APIerror.notData)
                    return
                }
                resolver.fulfill(data)
            }
        }
    }

    func getParsedData(_ data: Data) -> Promise<News> {
        return Promise  { resolver in
            do {
                let response = try JSONDecoder().decode(NewsResponse.self, from: data).response
                resolver.fulfill(response)
            } catch {
                print(error)
                resolver.reject(APIerror.decodeError)
            }
        }
    }

    func getNews(_ items: News) -> Promise<[NewsItem]> {
        return Promise<[NewsItem]> { resolver in
            var news = items.items
            let groups = items.groups
            let profiles = items.profiles

            for i in 0..<news.count {
                if news[i].sourceId < 0 {
                    let group = groups.first(where: { $0.id == -news[i].sourceId })
                    news[i].photoURL = group?.photo
                    news[i].authorName = group?.name ?? ""
                } else {
                    let profile = profiles.first(where: { $0.id == news[i].sourceId })
                    news[i].photoURL = profile?.photo
                    news[i].authorName = profile?.name ?? ""
                }
            }
            resolver.fulfill(news)
        }
    }
}
