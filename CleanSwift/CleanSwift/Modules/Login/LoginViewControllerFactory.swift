//
//  LoginViewControllerFactory.swift
//  CleanSwift
//
//  Created by Henry on 9/13/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation
import BusinessLogic

struct LoginViewControllerFactory {
    private let entityManager: EntityManager
    private let injector: InjectorProtocol
    
    init?(injector: InjectorProtocol) {
        guard let entityManager = injector.getInstance(for: EntityManager.self) else { return nil }
        self.entityManager = entityManager
        self.injector = injector
    }
    
    func build(routerDelegate: LoginRouterDelegate) -> LoginViewController? {
        let viewController = LoginViewController(nibName: "LoginView", bundle: nil)
        let interactor = LoginInteractor(entityManager: entityManager)
        let presenter = LoginPresenter()
        let router = LoginRouter()
        router.delegate = routerDelegate
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
