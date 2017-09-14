//
//  ItemDetailViewControllerFactory.swift
//  CleanSwift
//
//  Created by Henry on 9/13/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation
import BusinessLogic
import ITunesFeed

struct ItemDetailViewControllerFactory {
    private let entityManager: EntityManager
    init?(injector: InjectorProtocol) {
        guard let entityManager = injector.getInstance(for: EntityManager.self)
            else {
                return nil
        }
        self.entityManager = entityManager
    }
    func build() -> ItemDetailViewController? {
        guard let viewController = UIStoryboard(name: "ItemDetailViewController",
                                                bundle: nil).instantiateInitialViewController()
            as? ItemDetailViewController else {
                return nil
        }
        let interactor = ItemDetailInteractor()
        let presenter = ItemDetailPresenter()
        let router = ItemDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
