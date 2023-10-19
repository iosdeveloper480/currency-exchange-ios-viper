//
//  RegisterRouter.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class RegisterRouter: RegisterPresenterToRouterProtocol {
    static func createModule() -> RegisterView {
        let view = RegisterView()
        
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor()
        let router = RegisterRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToDashboard(navigationConroller: UINavigationController) {
        
    }
}
