//
//  ResultStateUtil.swift
//  LoginDemo
//
//  Created by xuzheng on 2022/6/17.
//


import Foundation
import RxSwift
import RxCocoa

//用于处理结果状态
enum Result {
    case success(message: String)
    case failure(message: String)
}

extension Result {
    //字体颜色
    var textColor: UIColor {
        switch self {
        case .success:
            return UIColor.black
        default:
            return UIColor.red
        }
    }
    //返回是否成功
    var isValid : Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    //描述字体
    var description: String {
        switch self {
        case let .success(message):
            return message
        case let .failure(message):
            return message
        }
    }
}

// MARK: 创建UILabel的监听者,改变字体和颜色
extension Reactive where Base: UILabel {
    var validationResult: Binder<Result> {
        return Binder(base, binding: { (label, result) in
            label.textColor = result.textColor
            label.text = result.description
        })
    }
}


// MARK: 创建UITextField的监听者,是否可编辑
extension Reactive where Base: UITextField {
    var enableResult: Binder<Result> {
        return Binder(base, binding: { (textField, result) in
            textField.isEnabled = result.isValid
        })
    }
}


//MARK: 创建UIButton的监听者,是否可编辑下的背景颜色
extension Reactive where Base: UIButton {
    var backColorResult: Binder<Bool> {
        return Binder(base, binding: { (button, result) in
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = result ? UIColor.red : UIColor.lightGray
        })
    }
}
