//
//  BaseRxRequest.swift
//  UnitelSDK
//
//  Created by admin on 1/15/21.
//

import Foundation
import RxAlamofire
import RxSwift
import Alamofire
import ObjectMapper

class BaseRxService {
    let disposeBag = DisposeBag()
    let session = Session.default
    
    func request<T: Mappable>(type:T.Type, method:HTTPMethod = .get, url: String, parameters: ([String: String])? = nil, encoding: ParameterEncoding = JSONEncoding.default) -> Observable<T> {
        return Observable.create { (observer) -> Disposable in
            self.session
                .rx
                .responseJSON(method, url, parameters: parameters, encoding: encoding)
                .subscribe(onNext: { (response, data) in
                    let result = self.parse(response: response, data: data) as Result<T, ApiError>
                    switch result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let object):
                        observer.onNext(object)
                    }
                    
                }, onError: { err in
                    observer.onError(ApiError(errorCode: .requestError, message: err.localizedDescription))
                }, onCompleted: {
                    observer.onCompleted()
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
   }
    
    func parse<T: Mappable>(response: HTTPURLResponse, data: Any) -> Result<T, ApiError> {
        if let data = data as? [String : Any],
            let parseData = MVBaseContainerObject<T>(JSON: data),
            let object = parseData.data {
            if parseData.result > 0 {
                return .success(object)
            } else {
                return .failure(ApiError(errorCode: .serverError, message: parseData.errorMessage))
            }
        }
        return .failure(ApiError(errorCode: .parseError, message: ""))
    }
}
