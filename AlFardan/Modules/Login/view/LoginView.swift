//
//  LoginView.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class LoginView: UIViewController {
    
    var presenter: LoginViewToPresenterProtocol?
    var fieldsView: LoginFieldsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Login"
        self.setupFieldsView()
    }
}
extension LoginView: LoginPresenterToViewProtocol {
    func success() {
        DispatchQueue.main.async {
            self.presenter?.showDashboard(navigationController: self.navigationController!)
        }
    }
    
    func failure(message: String) {
        print(message)
    }
}

extension LoginView {
    private func setupFieldsView() {
        self.fieldsView = LoginFieldsView()
        self.fieldsView?.translatesAutoresizingMaskIntoConstraints = false
        self.fieldsView?.delegate = self
        self.view.addSubview(self.fieldsView!)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.fieldsView!, attribute: .centerY, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1, constant: -50),
            NSLayoutConstraint(item: self.fieldsView!, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: self.fieldsView!, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -20),
        ])
    }
}

extension LoginView: LoginFieldsProtocol {
    func didTapLoginButton(username: String?, password: String?) {
        Task {
            await self.presenter?.didTapLogin(username: username!, password: password!)
        }
    }
    
    func didTapRegisterButton() {
        self.presenter?.showRegister(navigationController: navigationController!)
    }
    
    func inputFieldError(message: String) {
        print(message)
    }
}
