//
//  LoginImaginato.swift
//  TestLogin
//
//  Created by NHK on 1/26/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import Foundation

class LoginImaginatoService: BaseRxService {
    override func parse<T: LoginObject>(response: HTTPURLResponse, data: Any) -> Result<T, ApiError> {
        if let data = data as? [String : Any],
            let parseData = MVBaseContainerObject<T>(JSON: data),
            let object = parseData.data {
            if parseData.result > 0 {
                object.xacc = response.headers["X-Acc"] ?? ""
                return .success(object)
            } else {
                return .failure(ApiError(errorCode: .serverError, message: parseData.errorMessage))
            }
        }
        return .failure(ApiError(errorCode: .parseError, message: ""))
    }
}
