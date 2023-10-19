//
//  IntroPresenter.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class IntroPresenter: ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingPages() {
        interactor?.fetch()
    }
    
    func showLoginController(navigationController: UINavigationController) {
        router?.pushToLoginView(navigationConroller: navigationController)
    }
}

extension IntroPresenter: InteractorToPresenterProtocol {
    func fetch(pages: Array<Pages>) {
        view?.show(pages: pages)
    }
}
