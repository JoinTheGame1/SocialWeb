//
//  ResponseNews.swift
//  SocialWeb
//
//  Created by Никитка on 06.11.2021.
//

import UIKit

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct NewsResponse: Codable {
    let response: News
}

struct News: Codable {
    let items: [NewsItem]
    let profiles: [Friend]
    let groups: [Group]
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
}

struct NewsItem: Codable {
    let sourceId: Int
    let postId: Int
    let date: Double
    let text: String
    let likes: Like?
    let reposts: NewsRepost?
    let comments: NewsComment?
    let attachments: [Attachment]?
    var photoURL: String?
    var authorName: String?
    var photosURL: [String]? {
        get {
            let photosURL = attachments?.compactMap{ $0.photo?.sizes.last?.url }
            return photosURL
        }
    }
    var aspectRatio: CGFloat {
        get {
            let aspectRatio = attachments?.compactMap{ $0.photo?.sizes.last?.aspectRatio }.last
            return aspectRatio ?? 1
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case postId = "post_id"
        case date
        case text
        case likes
        case reposts
        case comments
        case attachments
        case photoURL
        case authorName
    }
    
    func getStringDate() -> String {
        let dateFormatter = MyRelativeDateTimeFormatter()
        return dateFormatter.timeAgoDisplay(timeIntervalSince1970: date)
    }
}

struct Attachment: Codable {
    let photo: Photo?
}

struct NewsRepost: Codable {
    let count: Int
    let user_reposted: Int
    
    var reposted: Bool { return user_reposted == 1 }
}

struct NewsComment: Codable {
    let count: Int
}
