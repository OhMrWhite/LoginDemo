//
//  BYHomeViewModel.swift
//  LoginDemo
//
//  Created by xuzheng on 2022/6/17.
//

import UIKit
import RxCocoa
import RxSwift

final class BYHomeViewModel {

    var password = BehaviorRelay(value: "")
    var passwordLevelObserable: Observable<PasswordStrengthLevel>
    var passwordObserable: Observable<String>
    init() {
        passwordLevelObserable = password.asObservable().map({ (password) -> PasswordStrengthLevel in
            return PasswordStrengthUtil.passwordStengthChecker(password)
        })
        passwordObserable = password.asObservable().map({ (password) -> String in
            return password
        })
    }
    
}


//MARK: 创建UIlabel的监听者,设置密码强度文字及颜色
extension Reactive where Base: UILabel {
    var passwordLevel: Binder<PasswordStrengthLevel> {
        return Binder(base, binding: { (label, level) in
            label.text = level.description
            label.textColor = level.color
        })
    }
}
