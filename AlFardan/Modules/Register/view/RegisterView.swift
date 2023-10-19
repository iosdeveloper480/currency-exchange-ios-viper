//
//  LoginView.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class RegisterView: UIViewController {
    
    var presenter: RegisterViewToPresenterProtocol?
    var fieldsView: RegisterFieldsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Register"
        self.setupFieldsView()
    }
}
extension RegisterView: RegisterPresenterToViewProtocol {
    func success() {
        presenter?.showDashboard(navigationController: navigationController!)
    }
    
    func failure(message: String) {
        print(message)
    }
}

extension RegisterView {
    private func setupFieldsView() {
        self.fieldsView = RegisterFieldsView()
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

extension RegisterView: RegisterFieldsProtocol {
    func didTapLoginButton(username: String?, password: String?) {
        Task {
            await self.presenter?.didTapLogin(username: username!, password: password!)
        }
    }
    
    func inputFieldError(message: String) {
        print(message)
    }
}
