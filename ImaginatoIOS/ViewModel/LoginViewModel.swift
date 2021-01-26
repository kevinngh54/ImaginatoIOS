//
//  ViewModel.swift
//  TestLogin
//
//  Created by NHK on 1/25/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {
    var username = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    var isValidUsername: Observable<Bool> {
        return username.filter({ !$0.isEmpty }).map{ self.isEmail($0) }
    }
    var isValidPassword: Observable<Bool> {
        return password.filter({ !$0.isEmpty }).map{ self.isPassword($0) }
    }
    var showAlert = PublishSubject<String>()
    var disposeBag = DisposeBag()
    
    func isEmail(_ string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: string)
    }
    
    func isPassword(_ string: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{3,16}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: string)
    }
    
    func login() {
        
    }
    
}
