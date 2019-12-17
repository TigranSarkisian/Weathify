//
//  File.swift
//  Weathify
//
//  Created by macbook-097 on 12/11/19.
//  Copyright © 2019 Tigran Sarkisyan. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

extension NSObject {
    class var className: String {
        return "\(self)"
    }
}

extension Request: ReactiveCompatible { }

extension Reactive where Base: DataRequest {
    func responseDecodable<T: Codable>() -> Observable<T> {
        return Observable.create { observer in
            let request = self.base.responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create { request.cancel() }
        }
    }
}
