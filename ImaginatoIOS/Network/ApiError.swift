//
//  ApiError.swift
//  UnitelSDK
//
//  Created by admin on 1/18/21.
//

import Foundation

protocol ErrorType: Error {
    var errorCode: ApiErrorCode { get set }
    var message: String { get set }
}

struct ApiError: ErrorType {
    var errorCode: ApiErrorCode
    var message: String
}

public enum ApiErrorCode: Int {
    case parseError = 999
    case requestError = -1
    case serverError = -2
}
