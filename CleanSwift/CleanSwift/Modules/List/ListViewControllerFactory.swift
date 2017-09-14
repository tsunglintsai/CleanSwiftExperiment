//
//  ListViewControllerBuilder.swift
//  CleanSwift
//
//  Created by Henry on 9/13/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation
import BusinessLogic
import ITunesFeed

struct ListViewControllerFactory {
    private let entityManager: EntityManager
    private let api: ITunesFeedAPIProtocol
    private let injector: InjectorProtocol
    init?(injector: InjectorProtocol) {
        guard let entityManager = injector.getInstance(for: EntityManager.self),
            let api = injector.getInstance(for: ITunesFeedAPIProtocol.self)
        else {
            return nil
        }
        self.entityManager = entityManager
        self.api = api
        self.injector = injector
    }
    func build() -> ListViewController? {
        guard let viewController = UIStoryboard(name: "ListViewController",
                                                bundle: nil).instantiateInitialViewController() as? ListViewController,
            let itemDetailViewControllerFactory = ItemDetailViewControllerFactory(injector: injector)
            else {
                return nil
        }
        let worker = ListWorker(api: api)
        let interactor = ListInteractor(worker: worker)
        let presenter = ListPresenter()
        let router = ListRouter(itemDetailViewControllerFactory: itemDetailViewControllerFactory)
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
