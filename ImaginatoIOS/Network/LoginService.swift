//
//  LoginService.swift
//  UnitelSDK
//
//  Created by admin on 1/18/21.
//

import Foundation
import RxSwift

protocol LoginServiceType {
    func login(userName: String, password: String) -> Observable<LoginObject>
}

class LoginService: LoginServiceType {
    private let baseService = LoginImaginatoService()
    func login(userName: String, password: String) -> Observable<LoginObject> {
        var params = [String:String]()
        params["email"] = userName
        params["password"] = password
        return baseService.request(type: LoginObject.self, method: .post, url: AppURL.login, parameters: params)
    }
}
