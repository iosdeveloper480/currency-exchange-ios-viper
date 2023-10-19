//
//  DashboardFieldsView.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit
import Combine

class DashboardFieldsView: UIView {
    
//    weak var delegate: RegisterFieldsProtocol?
//    private var usernameTextField = UITextField()
//    private var passwordTextField = UITextField()
    
    @Published var sendingAmount: String = ""
    @Published var sendingInputAmount: String = ""
    @Published var receivedAmount: String = ""
    @Published var receivedInputAmount: String = ""
    @Published var didTapSelect: Bool = false
    @Published var buttonTitle: String = "Select"
    private var subscriptions = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension DashboardFieldsView {
    private func setupViews() {
        
        self.backgroundColor = UIColor(named: "primary")
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Currency Converter"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
        ])
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Use our convenient converter tool to see how much your money is worth in another currency."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
        ])
        
        let senderAmountLabel = UILabel()
        senderAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        senderAmountLabel.text = "AMOUNT YOU WILL SEND"
        senderAmountLabel.numberOfLines = 0
        senderAmountLabel.textAlignment = .center
        senderAmountLabel.textColor = .white
        senderAmountLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        self.addSubview(senderAmountLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: senderAmountLabel, attribute: .top, relatedBy: .equal, toItem: descriptionLabel, attribute: .bottom, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: senderAmountLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: senderAmountLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
        ])
        
        let senderView = SenderInputFieldView()
        senderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(senderView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: senderView, attribute: .top, relatedBy: .equal, toItem: senderAmountLabel, attribute: .bottom, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: senderView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: senderView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: senderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
        ])
        
        senderView.$amount.sink { value in
            self.sendingInputAmount = value
        }.store(in: &self.subscriptions)
        
        let receiverAmountLabel = UILabel()
        receiverAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        receiverAmountLabel.text = "RECEIVER WILL GET"
        receiverAmountLabel.numberOfLines = 0
        receiverAmountLabel.textAlignment = .center
        receiverAmountLabel.textColor = .white
        receiverAmountLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        self.addSubview(receiverAmountLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: receiverAmountLabel, attribute: .top, relatedBy: .equal, toItem: senderView, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: receiverAmountLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: receiverAmountLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
        ])
        
        let receiverView = ReceiverInputFieldView()
        receiverView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(receiverView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: receiverView, attribute: .top, relatedBy: .equal, toItem: receiverAmountLabel, attribute: .bottom, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: receiverView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: receiverView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: receiverView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: receiverView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -40),
        ])
        receiverView.$didTapSelect.sink { value in
            self.didTapSelect = value
        }.store(in: &self.subscriptions)
        self.$buttonTitle.sink { value in
            receiverView.currencyButton.setTitle(value, for: .normal)
        }.store(in: &self.subscriptions)
        self.$receivedAmount.sink { value in
            receiverView.amountTextField.text = value
        }.store(in: &self.subscriptions)
        receiverView.$amount.sink { value in
            self.receivedInputAmount = value
        }.store(in: &self.subscriptions)
        self.$sendingAmount.sink { value in
            senderView.amountTextField.text = value
        }.store(in: &self.subscriptions)
    }
    
    @objc private func didTapLoginButton(_ sender: UIButton) {
//        if self.usernameTextField.text!.isEmpty {
////            self.delegate?.inputFieldError(message: "Username field is empty")
//        } else if self.passwordTextField.text!.isEmpty {
////            self.delegate?.inputFieldError(message: "Password field is empty")
//        } else {
////            self.delegate?.didTapLoginButton(username: self.usernameTextField.text, password: self.passwordTextField.text)
//        }
    }
}
extension DashboardFieldsView: UITextFieldDelegate {}


class SenderInputFieldView: UIView {
    
    @Published var amount: String = ""
    private var subscriptions = Set<AnyCancellable>()
    
    var amountTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5
        
        
        let currencyLabel = UILabel()
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.text = "AED"
        currencyLabel.tintColor = UIColor(named: "primary")
        self.addSubview(currencyLabel)
        currencyLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        currencyLabel.setContentHuggingPriority(.required, for: .horizontal)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: currencyLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: currencyLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: currencyLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: currencyLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
        ])
        
        
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
//        usernameTextField.delegate = self
        amountTextField.tag = 100
        amountTextField.placeholder = "Enter Amount"
        amountTextField.borderStyle = .none
        amountTextField.tintColor = .white
        self.addSubview(amountTextField)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: amountTextField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: amountTextField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: amountTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: amountTextField, attribute: .trailing, relatedBy: .equal, toItem: currencyLabel, attribute: .leading, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: amountTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
        ])
        
        
        amountTextField.textPublisher.sink { value in
            self.amount = value
        }.store(in: &self.subscriptions)
        
    }
}


class ReceiverInputFieldView: UIView {
    
    @Published var amount: String = ""
    @Published var didTapSelect: Bool = false
    var currencyButton = UIButton()
    var amountTextField = UITextField()
    private var subscriptions = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5
        
        currencyButton.translatesAutoresizingMaskIntoConstraints = false
        currencyButton.setTitle("Select", for: .normal)
        currencyButton.setTitleColor(UIColor(named: "primary"), for: .normal)
        currencyButton.addTarget(self, action: #selector(self.didTapSelectButton), for: .touchUpInside)
        self.addSubview(currencyButton)
        currencyButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        currencyButton.setContentHuggingPriority(.required, for: .horizontal)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: currencyButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: currencyButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: currencyButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: currencyButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
        ])
        
        
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
//        amountTextField.isUserInteractionEnabled = false
//        usernameTextField.delegate = self
        amountTextField.tag = 100
        amountTextField.placeholder = "Updating..."
        amountTextField.borderStyle = .none
        amountTextField.tintColor = .white
        self.addSubview(amountTextField)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: amountTextField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: amountTextField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: amountTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: amountTextField, attribute: .trailing, relatedBy: .equal, toItem: currencyButton, attribute: .leading, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: amountTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
        ])
        
        amountTextField.textPublisher.sink { value in
            self.amount = value
        }.store(in: &self.subscriptions)
        
    }
    
    @objc private func didTapSelectButton() {
        self.didTapSelect = true
    }
}
