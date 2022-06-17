//
//  PasswordStrengthUtil.swift
//  LoginDemo
//
//  Created by xuzheng on 2022/6/17.
//

import Foundation
import UIKit

//密码字符类型
struct PasswordCharacterType:OptionSet {
    let rawValue: Int
    
   static let  num = PasswordCharacterType(rawValue: 1)// 数字
   static let  small_letter = PasswordCharacterType(rawValue: 2)//小写字母
   static let  capital_letter = PasswordCharacterType(rawValue: 4)//大写字母
   static let  other_letter = PasswordCharacterType(rawValue: 8)//其他字符
}
// 密码强度级别
enum PasswordStrengthLevel {
    case low
    case medium
    case strong
    case veryStrong
}
// 密码强度状态的描述
extension PasswordStrengthLevel {
    var color:UIColor {
        switch self {
        case .low:
            return .red
        case .medium:
            return .orange
        case .strong:
            return .green
        case .veryStrong:
            return .blue
        }
    }
    var description:String {
        switch self {
        case .low:
            return "弱".localized
        case .medium:
            return "中等".localized
        case .strong:
            return "强".localized
        case .veryStrong:
            return "非常强".localized
        }
    }
}
class PasswordStrengthUtil {
    
    //校验密码强度
    static func passwordStengthChecker(_ password:String) -> PasswordStrengthLevel {
        if password.count <= 8 {
            return .low
        }
        let characterType =   passwordTypeChecker(password)
        if characterType.contains([.num,.capital_letter,.small_letter,.other_letter]) {
            return .veryStrong
        }
        if characterType.contains([.num,.capital_letter,.small_letter]) || characterType.contains([.num,.other_letter,.small_letter]) || characterType.contains([.num,.capital_letter,.other_letter]) || characterType.contains([.small_letter,.capital_letter,.other_letter]) {
            return .strong
        }
        if characterType.contains([.num,.small_letter]) ||
           characterType.contains([.num,.capital_letter]) ||
           characterType.contains([.num,.other_letter]) ||
           characterType.contains([.small_letter,.capital_letter]) ||
           characterType.contains([.small_letter,.other_letter]) ||    characterType.contains([.capital_letter,.other_letter]){
            return .medium
        }
        if  characterType.contains(.num) ||
                characterType.contains(.capital_letter) ||
                characterType.contains(.other_letter) ||
                characterType.contains(.small_letter){
            return .low
        }
        return .low
    }
    /// 包含的字符类型
    private static func passwordTypeChecker(_ password:String) -> PasswordCharacterType {
        var characterType: PasswordCharacterType = []
        for scalar in password.unicodeScalars {
            switch scalar.value {
            case 48...57:
                characterType.insert(.num)
            case 65...90:
                characterType.insert(.capital_letter)
            case 97...122:
                characterType.insert(.small_letter)
            default:
                characterType.insert(.other_letter)
            }
        }
        return characterType
    }
}


