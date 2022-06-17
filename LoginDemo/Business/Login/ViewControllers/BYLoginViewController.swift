//
//  BYLoginViewController.swift
//  LoginDemo
//
//  Created by xuzheng on 2022/6/17.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

class BYLoginViewController: UIViewController {

    @IBOutlet weak var emailTipLb: UILabel!
    @IBOutlet weak var passwordTipLb: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    var disposeBag = DisposeBag()
    let loginVM = BYLoginViewModel()

    //MARK:- 初始化界面 及 数据
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        initData()
    }
    ///初始化NAV
    func initNav() -> () {
        title = "登录".localized
    }
    ///初始化数据
    func initData() -> () {
        setupObserable()
    }
}

extension BYLoginViewController {
    func setupObserable()  {
        emailTF.rx.text
            .orEmpty
            .bind(to: loginVM.email) // 绑定email数据
            .disposed(by: disposeBag)
        passwordTF.rx.text
            .orEmpty
            .bind(to: loginVM.password) // 绑定密码数据
            .disposed(by: disposeBag)
        // 根据email监听提示字体的状态
        loginVM.emailObserable
            .skip(2)
            .bind(to: emailTipLb.rx.validationResult)
            .disposed(by: disposeBag)
        //根据email监听密码输入框的状态
        loginVM.emailObserable
            .bind(to: passwordTF.rx.enableResult)
            .disposed(by: disposeBag)
        //根据密码提示字体的状态
        loginVM.passwordObserable
            .skip(2)
            .bind(to: passwordTipLb.rx.validationResult)
            .disposed(by: disposeBag)
        //绑定登录按钮
        loginVM.loginBtnObserable.bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
        //根据登录状态更改按钮颜色
        loginVM.loginBtnObserable.bind(to: loginBtn.rx.backColorResult).disposed(by: disposeBag)

        //登录点击
        loginBtn?.rx.tap.subscribe(onNext: {[weak self] in
            self?.loginVM.loadData {[weak self] isSuccess in
                if isSuccess {
                    let home = BYHomeViewController()
                    home.homeVM.password.accept(self!.loginVM.password.value)
                    self?.navigationController?.pushViewController(home, animated: true)
                }
            }
        }).disposed(by: disposeBag)

    }

}
