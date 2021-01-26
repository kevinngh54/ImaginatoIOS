//
//  LoginModel.swift
//  TestLogin
//
//  Created by NHK on 1/26/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class LoginObject: Object, Mappable {
    @objc dynamic var userId = 0
    @objc dynamic var userName = ""
    @objc dynamic var createdAt: Date?
    @objc dynamic var xacc = ""
    
    required init?(map: Map) {
        
    }
    override init() {
        
    }
    
    func mapping(map: Map) {
        userId <- map["user.userId"]
        userName <- map["user.userName"]
        var createdString = ""
        createdString <- map["user.created_at"]
        createdAt = createdString.toDateYYYYMMDDHHMMSS()
    }
}
