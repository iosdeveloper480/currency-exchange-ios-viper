//
//  DashboardView.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit
import Combine

class DashboardView: UIViewController {
    
    var presenter: DashboardViewToPresenterProtocol?
    private var fieldsView: DashboardFieldsView?
    private var subscriptions = Set<AnyCancellable>()
    
    let dummy = UITextField(frame: .zero)
    var myPicker: UIPickerView! = UIPickerView()
    
    var availableCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return locales.compactMap { $0.currency?.identifier }
    }()
    
    var countryCurrency = [CurrencyModel]()
    var currencyRates = [CurrencyModel]()
    
    var aedRate: Double = 1.0
    var selectedReciverCurrency: CurrencyModel?
    var sendingAmount: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Dashboard"
        self.setupFieldsView()
        
        availableCurrencies.removeDuplicates()
        countryCurrency = availableCurrencies.map({CurrencyModel(country: currencyName(currencyCode: $0), currency: $0)})
        countryCurrency = countryCurrency.sorted { $0.country < $1.country }
        
        Task {
            await presenter?.loadCurrencyRates()
        }
    }
    
    private func currencyName(currencyCode: String) -> String {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode]))
        return locale.localizedString(forCurrencyCode: currencyCode) ?? currencyCode
    }
}
extension DashboardView: DashboardPresenterToViewProtocol {
    func fetchedCurrency(rates: [CurrencyModel]) {
        self.currencyRates = rates
        self.aedRate = rates.filter({$0.currency == "AED"}).first!.value
    }
    
    func success() {
        
    }
    
    func failure(message: String) {
        print(message)
    }
}

extension DashboardView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    private func setupFieldsView() {
        self.fieldsView = DashboardFieldsView()
        self.fieldsView?.translatesAutoresizingMaskIntoConstraints = false
        //        self.fieldsView?.delegate = self
        self.view.addSubview(self.fieldsView!)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.fieldsView!, attribute: .centerY, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1, constant: -50),
            NSLayoutConstraint(item: self.fieldsView!, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: self.fieldsView!, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -20),
        ])
        
        view.addSubview(dummy)
        self.dummy.inputView = myPicker
        self.myPicker = UIPickerView(frame: CGRectMake(0, 40, 0, 0))
        self.myPicker.delegate = self
        self.myPicker.dataSource = self
        self.myPicker.isHidden = true
        dummy.isHidden = true
        self.pickerToolbar()
        
        self.fieldsView?.$sendingInputAmount.sink(receiveValue: { value in
            self.sendingAmount = Double(value) ?? 0.0
            if let selectedReciverCurrency = self.selectedReciverCurrency {
                let selectedCurrencyRateWRT_AED = selectedReciverCurrency.value / self.aedRate
                print(selectedCurrencyRateWRT_AED)
                let receiverAmount = selectedCurrencyRateWRT_AED * self.sendingAmount
                self.fieldsView?.receivedAmount = "\(receiverAmount.rounded(toPlaces: 3))"
            }
        }).store(in: &self.subscriptions)
        self.fieldsView?.$didTapSelect.sink(receiveValue: { value in
            if value {
                self.myPicker.isHidden = false
                self.dummy.isHidden = false
                self.dummy.becomeFirstResponder()
            }
        }).store(in: &self.subscriptions)
        
        self.fieldsView?.$receivedInputAmount.sink { value in
            var sendingAmount: Double = 0.0
            if let selectedReciverCurrency = self.selectedReciverCurrency {
                let selectedCurrencyRateWRT_AED = self.aedRate / selectedReciverCurrency.value
                sendingAmount = selectedCurrencyRateWRT_AED * (Double(value) ?? 0)
            }
            self.sendingAmount = sendingAmount.rounded(toPlaces: 8)
            self.fieldsView?.sendingAmount = "\(self.sendingAmount)"
        }.store(in: &self.subscriptions)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableCurrencies.count
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(countryCurrency[row].country) (\(countryCurrency[row].currency))"
    }
    
    private func pickerToolbar() {
        //Create the view
        let tintColor = UIColor(red: 101.0/255.0, green: 98.0/255.0, blue: 164.0/255.0, alpha: 1.0)
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        myPicker.tintColor = tintColor
        myPicker.center.x = inputView.center.x
        inputView.addSubview(myPicker) // add date picker to UIView
        let doneButton = UIButton(frame: CGRectMake(100/2, 0, 100, 50))
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitle("Done", for: .highlighted)
        doneButton.setTitleColor(tintColor, for: .normal)
        doneButton.setTitleColor(tintColor, for: .highlighted)
        inputView.addSubview(doneButton) // add Button to UIView
        doneButton.addTarget(self, action: #selector(self.doneButton), for: .touchUpInside) // set button click event
        
        let cancelButton = UIButton(frame: CGRectMake((self.view.frame.size.width - 3*(100/2)), 0, 100, 50))
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitle("Cancel", for: .highlighted)
        cancelButton.setTitleColor(tintColor, for: .normal)
        cancelButton.setTitleColor(tintColor, for: .highlighted)
        inputView.addSubview(cancelButton) // add Button to UIView
        cancelButton.addTarget(self, action: #selector(self.cancelPicker), for: .touchUpInside) // set button click event
        dummy.inputView = inputView
    }
    @objc func cancelPicker() {
        self.dummy.resignFirstResponder()
    }
    @objc func doneButton() {
        let row = self.myPicker.selectedRow(inComponent: 0)
        let selectedCurrency = self.countryCurrency[row]
        self.fieldsView?.buttonTitle = selectedCurrency.currency
        self.selectedReciverCurrency = self.currencyRates.filter({$0.currency == selectedCurrency.currency}).first
        
        if let selectedReciverCurrency = self.selectedReciverCurrency {
            let selectedCurrencyRateWRT_AED = selectedReciverCurrency.value / self.aedRate
            print(selectedCurrencyRateWRT_AED)
            let receiverAmount = selectedCurrencyRateWRT_AED * self.sendingAmount
            self.fieldsView?.receivedAmount = "\(receiverAmount.rounded(toPlaces: 3))"
        }
        
        
        self.dummy.resignFirstResponder()
    }
}
