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
    
    ///判断是否为纯数字
    func isNumber() -> Bool {
        let numRegex = "^[0-9]*$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", numRegex)
        return predicate.evaluate(with: self)
    }
    /// 国际化
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
}
