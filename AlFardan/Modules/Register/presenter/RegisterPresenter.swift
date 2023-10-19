//
//  RegisterPresenter.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class RegisterPresenter: RegisterViewToPresenterProtocol {
    var view: RegisterPresenterToViewProtocol?
    
    var interactor: RegisterPresenterToInteratorProtocol?
    
    var router: RegisterPresenterToRouterProtocol?
    
    func didTapLogin(username: String, password: String) async {
        await interactor?.loginApi(username: username, password: password)
    }
    
    func showDashboard(navigationController: UINavigationController) {
        router?.pushToDashboard(navigationConroller: navigationController)
    }
}
extension RegisterPresenter: RegisterInteractorToPresenterProtocol {
    
    func fetchUser(data: UserModel?) {
        data?.save()
        view?.success()
    }
    
    func error(message: String) {
        view?.failure(message: message)
    }
}
