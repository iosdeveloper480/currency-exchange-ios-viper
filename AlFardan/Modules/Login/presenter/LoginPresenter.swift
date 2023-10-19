//
//  LoginPresenter.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class LoginPresenter: LoginViewToPresenterProtocol {
    var view: LoginPresenterToViewProtocol?
    
    var interactor: LoginPresenterToInteratorProtocol?
    
    var router: LoginPresenterToRouterProtocol?
    
    func didTapLogin(username: String, password: String) async {
        await interactor?.loginApi(username: username, password: password)
    }
    
    func showDashboard(navigationController: UINavigationController) {
        router?.pushToDashboard(navigationConroller: navigationController)
    }
    func showRegister(navigationController: UINavigationController) {
        router?.pushToRegister(navigationConroller: navigationController)
    }
}

extension LoginPresenter: LoginInteractorToPresenterProtocol {
    
    func fetchUser(data: UserModel?) {
        data?.save()
        view?.success()
    }
    
    func error(message: String) {
        view?.failure(message: message)
    }
}
