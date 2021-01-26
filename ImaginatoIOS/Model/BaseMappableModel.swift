//
//  BaseMappableModel.swift
//  TestLogin
//
//  Created by NHK on 1/26/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import Foundation
import ObjectMapper


class MVBaseContainerObject<T: Mappable>: Mappable {
    var result = 0
    var errorMessage = ""
    var data: T?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        errorMessage <- map["error_message"]
        result <- map["result"]
        data <- map["data"]
    }
}
