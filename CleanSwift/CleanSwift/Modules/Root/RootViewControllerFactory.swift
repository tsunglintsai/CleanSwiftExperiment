//
//  RootViewControllerBuilder.swift
//  CleanSwift
//
//  Created by Henry on 9/13/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation
import BusinessLogic
import Persistence
import ITunesFeed

struct RootViewControllerFactory {
    private let entityManager: EntityManager
    private let injector: InjectorProtocol
    init() {
        let injector = Injector()
        let entityManager = EntityManagerWithUserDefault()
        injector.add(instance: entityManager, for: EntityManager.self)
        injector.add(instance: ITunesFeed.createAPI(), for: ITunesFeedAPIProtocol.self)
        self.entityManager = entityManager
        self.injector = injector
    }
    
    func build() -> RootViewController? {
        guard let tabNavigationViewControllerFactory = TabNavigationViewControllerFactory(injector: injector) else { return nil }
        guard let loginViewControllerFactory = LoginViewControllerFactory(injector: injector) else { return nil }
        let viewController = RootViewController(nibName: nil, bundle: nil)
        let interactor = RootInteractor(entityManager: entityManager)
        let presenter = RootPresenter()
        let router = RootRouter(tableBarControllerFactory: tabNavigationViewControllerFactory,
                                loginViewControllerFactory:loginViewControllerFactory)
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
