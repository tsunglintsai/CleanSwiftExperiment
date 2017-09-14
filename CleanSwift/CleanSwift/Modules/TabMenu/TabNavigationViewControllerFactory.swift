//
//  TabNavigationViewControllerBuilder.swift
//  CleanSwift
//
//  Created by Henry on 9/13/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation
import BusinessLogic
import Persistence

struct TabNavigationViewControllerFactory {
    private let entityManager: EntityManager
    private let injector: InjectorProtocol
    
    init?(injector: InjectorProtocol) {
        guard let entityManager = injector.getInstance(for: EntityManager.self) else { return nil }
        self.entityManager = entityManager
        self.injector = injector
    }
    
    func build() -> TabNavigationViewController? {
        guard let listViewControllerFactory = ListViewControllerFactory(injector: injector),
            let trackCollectionViewControllerFactory = TrackCollectionViewControllerFactory(injector: injector)
            else {
                return nil
        }
        let viewController = TabNavigationViewController(nibName: nil, bundle: nil)
        let interactor = TabNavigationInteractor()
        let presenter = TabNavigationPresenter()
        let router = TabNavigationRouter(listViewControllerFactory: listViewControllerFactory,
                                         trackCollectionViewControllerFactory: trackCollectionViewControllerFactory)
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
