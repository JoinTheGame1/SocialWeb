//
//  Response.swift
//  SocialWeb
//
//  Created by Никитка on 18.11.2021.
//

import Foundation

class Response<T: Codable>: Codable {
    let response: Items<T>
}

class Items<T: Codable>: Codable {
    let items: [T]
}
