//
//  MySession.swift
//  SocialWeb
//
//  Created by Никитка on 20.09.2021.
//

import Foundation

class MySession {
    static let shared = MySession()
    
    var token: String = ""
    var userId: String = ""
    
    private init() {}
}

enum APIerror: Error {
    case notData
    case decodeError
    case serverError
}
