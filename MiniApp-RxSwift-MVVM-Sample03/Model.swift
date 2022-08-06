//
//  Model.swift
//  MiniApp-RxSwift-MVVM-Sample03
//
//  Created by 近藤米功 on 2022/08/06.
//

import RxSwift
import RxCocoa

enum ModelError: Error{
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
}

protocol ModelProtocol{
    func validate(idText: String?,passwordText: String?) -> Observable<Void>
}

final class Model: ModelProtocol{
    func validate(idText: String?, passwordText: String?) -> Observable<Void> {
        switch(idText,passwordText){
        case(.none, .none):
            return Observable.error(ModelError.invalidIdAndPassword)
        case(.none, .some):
            return Observable.error(ModelError.invalidId)
        case(.some, .none):
            return Observable.error(ModelError.invalidPassword)
        case(let idText?, let passwordText?):
            switch(idText.isEmpty,passwordText.isEmpty){
            case(true,true):
                return Observable.error(ModelError.invalidIdAndPassword)
            case(false,false):
                return Observable.just(())
            case(true,false):
                return Observable.error(ModelError.invalidId)
            case(false,true):
                return Observable.error(ModelError.invalidPassword)
            }
        }
    }
}
