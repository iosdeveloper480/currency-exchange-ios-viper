//
//  LoginRouter.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class DashboardRouter: DashboardPresenterToRouterProtocol {
    static func createModule() -> DashboardView {
        let view = DashboardView()
        
        let presenter = DashboardPresenter()
        let interactor = DashboardInteractor()
        let router = DashboardRouter()
        
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
