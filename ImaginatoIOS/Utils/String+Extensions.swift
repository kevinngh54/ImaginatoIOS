//
//  String+Extensions.swift
//  TestLogin
//
//  Created by NHK on 1/26/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import Foundation

extension String {
    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func toDateYYYYMMDDHHMMSS() -> Date? {
        return toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
}
