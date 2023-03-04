//
//  Router.swift
//  ViperCoreData
//
//  Created by Osinnowo Emmanuel on 04/03/2023.
//

import UIKit

typealias Entity = AnyView & UIViewController

protocol AnyRouter {
    static func start() -> AnyRouter
    var entry: Entity?  { get }
}

final class UserRouter: AnyRouter {
    var entry: Entity?
    
    static func start() -> AnyRouter {
        var router = UserRouter()
        var presenter = UserPresenter()
        var interactor = UserInteractor()
        var entry = UserViewController()
        entry.presenter = presenter
        
        interactor.presenter = presenter
        presenter.view = entry
        presenter.router = router
        presenter.interactor = interactor
        router.entry = entry
        
        return router
    }
    
    func navigate() { }
}
