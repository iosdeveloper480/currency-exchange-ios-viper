//
//  LoginRouter.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class LoginRouter: LoginPresenterToRouterProtocol {
    static func createModule() -> LoginView {
        let view = LoginView()
        
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToDashboard(navigationConroller: UINavigationController) {
        let router = DashboardRouter.createModule()
        navigationConroller.viewControllers[0] = router
    }
    
    func pushToRegister(navigationConroller: UINavigationController) {
        let router = RegisterRouter.createModule()
        navigationConroller.pushViewController(router, animated: true)
    }
}
