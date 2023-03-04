//
//  Presenter.swift
//  ViperCoreData
//
//  Created by Osinnowo Emmanuel on 04/03/2023.
//

import Foundation

protocol AnyPresenter {
    var view: AnyView? { get }
    var interactor: AnyInteractor? { get }
    var router: AnyRouter? { get }
    func fetchUserList()
    func didFetchUserList(with result: Result<[User], Error>)
}

final class UserPresenter: AnyPresenter {
    var view: AnyView?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.fetchUserRecord()
        }
    }
    
    var router: AnyRouter?
    
    func fetchUserList() {
        interactor?.fetchUserRecord()
    }
    
    func didFetchUserList(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            self.view?.update(with: users)
        case .failure(let error):
            self.view?.update(with: error)
        }
    }
}
