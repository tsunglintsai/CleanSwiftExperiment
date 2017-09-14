//
//  TrackCollectionViewControllerFactory.swift
//  CleanSwift
//
//  Created by Henry on 9/13/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation
import BusinessLogic
import ITunesFeed

struct TrackCollectionViewControllerFactory {
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
    func build() -> TrackCollectionViewController? {
        guard let viewController = UIStoryboard(name: "TrackCollectionViewController",
                                                bundle: nil).instantiateInitialViewController() as? TrackCollectionViewController,
            let itemDetailViewControllerFactory = ItemDetailViewControllerFactory(injector: injector)
            else {
                return nil
        }
        let interactor = ListInteractor(worker: ListWorker(api: ITunesFeed.createAPI()))
        let presenter = TrackCollectionPresenter()
        let router = TrackCollectionRouter(itemDetailViewControllerFactory: itemDetailViewControllerFactory)
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}

