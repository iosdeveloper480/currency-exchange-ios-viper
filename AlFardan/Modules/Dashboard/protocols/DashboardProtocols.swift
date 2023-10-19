//
//  LoginProtocols.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

protocol DashboardViewToPresenterProtocol: AnyObject {
    
    var view: DashboardPresenterToViewProtocol? {get set}
    var interactor: DashboardPresenterToInteratorProtocol? {get set}
    var router: DashboardPresenterToRouterProtocol? {get set}
    func loadCurrencyRates() async
    
}

protocol DashboardPresenterToViewProtocol: AnyObject {
    func fetchedCurrency(rates: [CurrencyModel])
    func success()
    func failure(message: String)
}

protocol DashboardPresenterToRouterProtocol: AnyObject {
    static func createModule() -> DashboardView
}

protocol DashboardPresenterToInteratorProtocol: AnyObject {
    var presenter: DashboardInteractorToPresenterProtocol? {get set}
    func loadCurrencyRates() async
}

protocol DashboardInteractorToPresenterProtocol: AnyObject {
    func fetchedCurrency(rates: [CurrencyModel])
    func fetchUser(data: UserModel?)
    func error(message: String)
}
