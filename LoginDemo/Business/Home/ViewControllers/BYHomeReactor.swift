//
//  BYHomeReactor.swift
//  LoginDemo
//
//  Created by xuzheng on 2022/6/20.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

final class BYHomeReactor: Reactor {
    var initialState: State
    enum Action {
        case submit
    }
    enum Mutation {
        case pop
    }
    struct State {
        var passwordLevel:PasswordStrengthLevel = .low
        var password:String = ""

    }
    init(password:String) {
        self.initialState = State(passwordLevel:  PasswordStrengthUtil.passwordStengthChecker(password), password: password)
    }
    
    
}
