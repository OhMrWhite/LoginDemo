//
//  BYLoginReactor.swift
//  LoginDemo
//
//  Created by xuzheng on 2022/6/18.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift
final class BYLoginReactor: Reactor {
    
    enum Action {
        case  login
        case  setPassword(String)
        case  setEmail(String)
    }
    enum Mutation {
        case setPassword(String)
        case setLoading(Bool)
        case nextPage(Bool)
        case setEmail(String)

    }
    struct State {
        var passwordState:Result = Result.failure(message: "")
        var emailState:Result = Result.failure(message: "")
        var isLoading:Bool = false
        var nextPage:Bool = false
        var password:String = ""
        var email:String = ""
    }
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .login:
            return Observable.concat([Observable.just(Mutation.setLoading(true)),
                                      self.loadData(email: self.currentState.email, password: self.currentState.password)
                                        .take(until: self.action.filter(Action.isLoginAction))
                                        .map({ success in
                if success {
                    return Mutation.nextPage(true)
                }else{
                    return Mutation.setLoading(false)
                }
            })
             ])
        case let .setEmail(email):
            return .just(Mutation.setEmail(email))
        case let .setPassword(passwd):
            return .just(Mutation.setPassword(passwd))
        }
    }
    func reduce(state:State,mutation:Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setPassword(passwd):
            newState.password = passwd
            newState.passwordState =  InputValidator.validatePassword(passwd)
        case let .setEmail(email):
            newState.email = email
            newState.emailState =  InputValidator.validateUserName(email)
        case let .setLoading(isLoading):
            newState.nextPage = false
            newState.isLoading = isLoading
        case let .nextPage(next):
            newState.isLoading = false
            newState.nextPage = next
        }
        return newState
    }
    
}
fileprivate extension BYLoginReactor {
    func loadData(email:String, password:String) ->Observable<Bool> {
        return Observable.of(true).delay(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
    }
}

extension BYLoginReactor.Action {
  static func isLoginAction(_ action: BYLoginReactor.Action) -> Bool {
    if case .login = action {
      return true
    } else {
      return false
    }
  }
}
