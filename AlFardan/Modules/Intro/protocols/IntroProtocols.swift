//
//  IntroProtocols.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: AnyObject {
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingPages()
    func showLoginController(navigationController: UINavigationController)
    
}

protocol PresenterToViewProtocol: AnyObject {
    func show(pages: Array<Pages>)
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule() -> IntroMainView
    func pushToLoginView(navigationConroller: UINavigationController)
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter: InteractorToPresenterProtocol? {get set}
    func fetch()
}

protocol InteractorToPresenterProtocol: AnyObject {
    func fetch(pages: Array<Pages>)
}
