//
//  MySession.swift
//  SocialWeb
//
//  Created by Никитка on 20.09.2021.
//

import Foundation

class MySession {
    let shared = MySession()
    
    var token: String = ""
    var userId: Int = 0
    
    private init(){}
}
