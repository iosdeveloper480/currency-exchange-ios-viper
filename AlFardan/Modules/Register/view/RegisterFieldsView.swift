//
//  LoginFieldsView.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class RegisterFieldsView: UIView {
    
    weak var delegate: RegisterFieldsProtocol?
    private var usernameTextField = UITextField()
    private var passwordTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension RegisterFieldsView {
    private func setupViews() {
        
        self.backgroundColor = UIColor(named: "primary")
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Register Now"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 60),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
        ])
        
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.delegate = self
        usernameTextField.tag = 100
        usernameTextField.placeholder = "Enter Username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.tintColor = .white
        self.addSubview(usernameTextField)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: usernameTextField, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: usernameTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: usernameTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: usernameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
        ])
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self
        passwordTextField.tag = 101
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.tintColor = .white
        passwordTextField.isSecureTextEntry = true
        self.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: usernameTextField, attribute: .bottom, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
        ])
        
        let loginButton = UIButton()
        loginButton.layer.masksToBounds = false
        loginButton.layer.cornerRadius = 5
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor(named: "primary"), for: .normal)
        loginButton.backgroundColor = .white
        loginButton.addTarget(self, action: #selector(self.didTapLoginButton(_:)), for: .touchUpInside)
        self.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: passwordTextField, attribute: .bottom, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: loginButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: loginButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: loginButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -60),
        ])
    }
    
    @objc private func didTapLoginButton(_ sender: UIButton) {
        if self.usernameTextField.text!.isEmpty {
            self.delegate?.inputFieldError(message: "Username field is empty")
        } else if self.passwordTextField.text!.isEmpty {
            self.delegate?.inputFieldError(message: "Password field is empty")
        } else {
            self.delegate?.didTapLoginButton(username: self.usernameTextField.text, password: self.passwordTextField.text)
        }
    }
}
extension RegisterFieldsView: UITextFieldDelegate {}
