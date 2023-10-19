//
//  LoginInteractor.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import Alamofire
import Combine

class LoginInteractor: LoginPresenterToInteratorProtocol {
    
    var presenter: LoginInteractorToPresenterProtocol?
    
    func loginApi(username: String, password: String) async {
//        let params = ["username": username, "password": password]
//        do {
//            let user = try await APIClient().post(model: UserModel.self, params: params)
//            self.presenter?.fetchUser(data: user)
//        } catch let error {
//            self.presenter?.error(message: error.localizedDescription)
//        }
        
        
        //If there is an API for login user, then we will use above code, Otherwise
        do {
            let localUser = try await LocalDataClient().fetchUser()
            if localUser.username.lowercased() == username.lowercased() && localUser.password.lowercased() == password.lowercased() {
                self.presenter?.fetchUser(data: localUser)
            } else {
                self.presenter?.error(message: "Username or password is invalid")
            }
        } catch let error {
            self.presenter?.error(message: error.localizedDescription)
        }
    }
}
