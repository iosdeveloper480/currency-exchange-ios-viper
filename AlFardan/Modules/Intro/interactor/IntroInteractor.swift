//
//  IntroInteractor.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation

class IntroInteractor: PresenterToInteractorProtocol {
    
    var presenter: InteractorToPresenterProtocol?
    
    func fetch() {
        presenter?.fetch(pages: Pages.allCases)
    }
}
