//
//  ViewController.swift
//  TestLogin
//
//  Created by NHK on 1/25/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: CommonTextField!
    @IBOutlet weak var passWordTextField: CommonTextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var viewModel = LoginViewModel(with: LoginService())
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindingData()
    }

    func bindingData() {
        userNameTextField.textField.rx.text.map({ $0! }).bind(to: viewModel.username).disposed(by: disposeBag)
        passWordTextField.textField.rx.text.map({ $0! }).bind(to: viewModel.password).disposed(by: disposeBag)
        
        viewModel.isValidUsername.subscribe(onNext: { [weak self] value in
            self?.userNameTextField.errorLabel.isHidden = value
        }).disposed(by: disposeBag)
        viewModel.isValidPassword.subscribe(onNext: { [weak self] value in
            self?.passWordTextField.errorLabel.isHidden = value
        }).disposed(by: disposeBag)
        viewModel.showAlert.subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            let _ = UIAlertController.present(in: self, title: "Error", message: value, style: .alert, actions: [.action(title: "OK")]).subscribe(onNext: { _ in
                
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.isValidUsername, viewModel.isValidPassword).map({$0 && $1}).subscribe(onNext: { [weak self] isValid in
            self?.signInButton.isEnabled = isValid
            }).disposed(by: disposeBag)
    }

    @IBAction func signInAction(_ sender: Any) {
        viewModel.login()
    }
}

