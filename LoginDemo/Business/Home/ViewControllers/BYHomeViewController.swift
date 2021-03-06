//
//  BYHomeViewController.swift
//  LoginDemo
//
//  Created by xuzheng on 2022/6/17.
//

import UIKit
import RxCocoa
import RxSwift
import ReactorKit
class BYHomeViewController: UIViewController,StoryboardView {
    
    @IBOutlet weak var passwordLevelLb: UILabel!
    
    @IBOutlet weak var passwordLevelTitle: UILabel!
    @IBOutlet weak var passwordLb: UILabel!
    let homeVM = BYHomeViewModel()
    var disposeBag = DisposeBag()
    convenience init(reactor: BYHomeReactor) {
      self.init()
      self.reactor = reactor
    }

    required convenience init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    //MARK:- 初始化界面 及 数据
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        initView()
        initData()
    }
    ///初始化NAV
    func initNav() -> () {
        title = "主页".localized
    }
    ///初始化View
    func initView() -> () {
    }
    ///初始化数据
    func initData() -> () {
        self.passwordLevelTitle.text = "当前密码强度".localized
        
//        self.passwordLevelLb.text = homeVM.password.value
//        homeVM.passwordLevelObserable.bind(to: passwordLevelLb.rx.passwordLevel).disposed(by: disposeBag)
//        homeVM.passwordObserable.bind(to: passwordLb.rx.text).disposed(by: disposeBag)
        
    }
    func bind(reactor: BYHomeReactor) {
        reactor.state.map{$0.password}
            .bind(to: passwordLb.rx.text)
            .disposed(by: disposeBag)
        reactor.state
            .map{$0.passwordLevel}
            .bind(to: passwordLevelLb.rx.passwordLevel)
            .disposed(by: disposeBag)
        
    }
}
