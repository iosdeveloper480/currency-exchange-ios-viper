//
//  DashboardPresenter.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class DashboardPresenter: DashboardViewToPresenterProtocol {
    
    var view: DashboardPresenterToViewProtocol?
    
    var interactor: DashboardPresenterToInteratorProtocol?
    
    var router: DashboardPresenterToRouterProtocol?
    
//    func didTapLogin(username: String, password: String) async {
//        await interactor?.loginApi(username: username, password: password)
//    }
    
    func loadCurrencyRates() async {
        return await interactor!.loadCurrencyRates()
    }
}
extension DashboardPresenter: DashboardInteractorToPresenterProtocol {
    func fetchedCurrency(rates: [CurrencyModel]) {
        view?.fetchedCurrency(rates: rates)
    }
    
    
    func fetchUser(data: UserModel?) {
        data?.save()
        view?.success()
    }
    
    func error(message: String) {
        view?.failure(message: message)
    }
}
