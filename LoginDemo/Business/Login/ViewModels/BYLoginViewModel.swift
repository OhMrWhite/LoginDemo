//
//  BYLoginViewModel.swift
//  LoginDemo
//
//  Created by xuzheng on 2022/6/17.
//

import Foundation
import RxCocoa
import RxSwift
import ProgressHUD
final class BYLoginViewModel {
    var email = BehaviorRelay(value: "")
    var password = BehaviorRelay(value: "")
    var emailObserable: Observable<Result>
    var passwordObserable: Observable<Result>
    var loginBtnObserable: Observable<Bool>
    init() {
        //检测账号
        emailObserable = email.asObservable().map({ (username) -> Result in
            return InputValidator.validateUserName(username)
        })
        //检测密码
        passwordObserable = password.asObservable().map({ (password) -> Result in
            return InputValidator.validatePassword(password)
        })
        //检测是否可以登录
        loginBtnObserable = Observable.combineLatest(emailObserable, passwordObserable, resultSelector: { (username, password) -> Bool in
            return  InputValidator.validateLogin(username, password).isValid
        })
    }
}
extension BYLoginViewModel {
    
    func loadData(completionHandler: @escaping (_ isSuccess: Bool) -> Void) {
        ProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            ProgressHUD.dismiss()
            completionHandler(true)
        })
    }
}
