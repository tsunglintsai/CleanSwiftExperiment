//
//  ListRouter.swift
//  CleanSwift
//
//  Created by Henry on 9/9/17.
//  Copyright (c) 2017 Henry Tsai. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import BusinessLogic

@objc protocol ListRoutingLogic {
    func routeToItemDetail(url: URL)
}

protocol ListDataPassing {
    var dataStore: ListDataStore? { get }
}

class ListRouter: NSObject {
    weak var viewController: ListViewController?
    var dataStore: ListDataStore?
    var itemDetailViewControllerFactory: ItemDetailViewControllerFactory
    init(itemDetailViewControllerFactory: ItemDetailViewControllerFactory) {
        self.itemDetailViewControllerFactory = itemDetailViewControllerFactory
        super.init()
    }
}
extension ListRouter {
    func navigateToSomewhere(source: ListViewController, destination: ItemDetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}

extension ListRouter: ListDataPassing {
    func passDataToItemDetail(source: ListDataStore, destination: inout ItemDetailDataStore) {
        destination.url = source.selectedItemURL
    }
}

extension ListRouter: ListRoutingLogic {
    func routeToItemDetail(url: URL) {
        guard let itemDetailViewController = itemDetailViewControllerFactory.build(),
            let viewController = viewController
            else { return }
        if let dataStore = dataStore, var destinationDataStore = itemDetailViewController.router?.dataStore {
            passDataToItemDetail(source: dataStore, destination: &destinationDataStore)
        }
        navigateToSomewhere(source: viewController, destination: itemDetailViewController)
    }
}
