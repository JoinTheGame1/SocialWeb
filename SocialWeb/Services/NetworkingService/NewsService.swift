//
//  NewsService.swift
//  SocialWeb
//
//  Created by Никитка on 08.11.2021.
//

import Foundation
import Alamofire

class NewsService {
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let version = "5.131"
    
    func getNews(completion: @escaping (Result<News, APIerror>) -> Void) {
        let method = "/newsfeed.get"

        let parameters: Parameters = [
            "filters": "post, photo",
            "access_token": token,
            "v": version,
            "count": 20,
            "start_from": "next_from"
        ]

        let url = baseUrl + method

        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                print(error)
            }

            guard let data = response.data else {
                completion(.failure(.notData))
                return
            }
            DispatchQueue.main.async {
                do {
                    let newsResponce = try JSONDecoder().decode(NewsResponce.self, from: data)
                    let news = newsResponce.response
                    completion(.success(news))
                } catch {
                    completion(.failure(.decodeError))
                }
            }
        }
    }
}
