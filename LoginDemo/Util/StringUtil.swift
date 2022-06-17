//
//  StringUtil.swift
//  LoginDemo
//
//  Created by xuzheng on 2022/6/17.
//

import Foundation

extension String {
    
    ///判断用户输入是否为邮箱
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
