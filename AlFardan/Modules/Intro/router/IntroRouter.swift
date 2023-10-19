//
//  IntroRouter.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class IntroRouter: PresenterToRouterProtocol {
    
    static func createModule() -> IntroMainView {
        let introMainView = IntroMainView()
        
        let presenter = IntroPresenter()
        let interactor = IntroInteractor()
        let router = IntroRouter()
        
        introMainView.presentor = presenter
        presenter.view = introMainView
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return introMainView
    }
    
    func pushToLoginView(navigationConroller: UINavigationController) {
        let router = LoginRouter.createModule()
        
        navigationConroller.viewControllers[0] = router
        navigationConroller.setNavigationBarHidden(false, animated: false)
    }
}
