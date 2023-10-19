//
//  LoginProtocols.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

protocol LoginFieldsProtocol: AnyObject {
    func didTapRegisterButton()
    func didTapLoginButton(username: String?, password: String?)
    func inputFieldError(message: String)
}



protocol LoginViewToPresenterProtocol: AnyObject {
    
    var view: LoginPresenterToViewProtocol? {get set}
    var interactor: LoginPresenterToInteratorProtocol? {get set}
    var router: LoginPresenterToRouterProtocol? {get set}
    func didTapLogin(username: String, password: String) async
    func showDashboard(navigationController: UINavigationController)
    func showRegister(navigationController: UINavigationController)
    
}

protocol LoginPresenterToViewProtocol: AnyObject {
    func success()
    func failure(message: String)
}

protocol LoginPresenterToRouterProtocol: AnyObject {
    static func createModule() -> LoginView
    func pushToDashboard(navigationConroller: UINavigationController)
    func pushToRegister(navigationConroller: UINavigationController)
}

protocol LoginPresenterToInteratorProtocol: AnyObject {
    var presenter: LoginInteractorToPresenterProtocol? {get set}
    func loginApi(username: String, password: String) async
}

protocol LoginInteractorToPresenterProtocol: AnyObject {
    func fetchUser(data: UserModel?)
    func error(message: String)
}
