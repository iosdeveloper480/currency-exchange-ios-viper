//
//  RegisterProtocols.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

protocol RegisterFieldsProtocol: AnyObject {
    func didTapLoginButton(username: String?, password: String?)
    func inputFieldError(message: String)
}



protocol RegisterViewToPresenterProtocol: AnyObject {
    
    var view: RegisterPresenterToViewProtocol? {get set}
    var interactor: RegisterPresenterToInteratorProtocol? {get set}
    var router: RegisterPresenterToRouterProtocol? {get set}
    func didTapLogin(username: String, password: String) async
    func showDashboard(navigationController: UINavigationController)
    
}

protocol RegisterPresenterToViewProtocol: AnyObject {
    func success()
    func failure(message: String)
}

protocol RegisterPresenterToRouterProtocol: AnyObject {
    static func createModule() -> RegisterView
    func pushToDashboard(navigationConroller:UINavigationController)
}

protocol RegisterPresenterToInteratorProtocol: AnyObject {
    var presenter: RegisterInteractorToPresenterProtocol? {get set}
    func loginApi(username: String, password: String) async
}

protocol RegisterInteractorToPresenterProtocol: AnyObject {
    func fetchUser(data: UserModel?)
    func error(message: String)
}
