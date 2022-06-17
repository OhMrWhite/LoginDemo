//
//  InputValidator.swift
//  LoginDemo
//
//  Created by xuzheng on 2022/6/17.
//

import Foundation
class InputValidator {

}

extension InputValidator {
    //判断密码长度
    class func isValidPassword(_ password: String, count:Int = 8) -> Bool {
        return password.count >= count
    }
    class func isVailidEmail(_ email:String) -> Bool {
        return email.validateEmail()
    }
    //判断用户名
    class func validateUserName(_ username: String) -> Result {
        //判断email是否正确
        if !username.validateEmail() {
            return Result.failure(message: "输入的Email格式错误")
        }
        //email可用
        return Result.success(message: "账号可用")
    }
    //判断密码
    class func validatePassword(_ password: String) -> Result {
        //判断密码长度
        if !isValidPassword(password) {
            return Result.failure(message: "输入的密码长度不足")
        }
        //密码可用
        return Result.success(message: "密码可用")
    }
    //判断用户名与密码
    class func validateLogin(_ email: Result, _ password : Result) -> Result {
        if email.isValid && password.isValid{
            return Result.success(message: "登录成功")
        }
        return Result.failure(message: "登录失败")
    }
}
