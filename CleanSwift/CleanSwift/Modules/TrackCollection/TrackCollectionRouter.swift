//
//  TrackCollectionRouter.swift
//  CleanSwift
//
//  Created by Henry on 9/11/17.
//  Copyright (c) 2017 Henry Tsai. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol TrackCollectionRoutingLogic {
    func routeToItemDetail(url: URL)
}

protocol TrackCollectionDataPassing {
	var dataStore: ListDataStore? { get }
}

class TrackCollectionRouter: NSObject {
	weak var viewController: TrackCollectionViewController?
	var dataStore: ListDataStore?
  
	// MARK: Routing
  
	//func routeToSomewhere(segue: UIStoryboardSegue?) {
	//  if let segue = segue {
	//    let destinationVC = segue.destination as! SomewhereViewController
	//    var destinationDS = destinationVC.router!.dataStore!
	//    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
	//  } else {
	//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
	//    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
	//    var destinationDS = destinationVC.router!.dataStore!
	//    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
	//    navigateToSomewhere(source: viewController!, destination: destinationVC)
	//  }
	//}
}

// MARK: Navigation
extension TrackCollectionRouter {
    func navigateToSomewhere(source: TrackCollectionViewController, destination: ItemDetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}

// MARK: Passing data
extension TrackCollectionRouter : TrackCollectionDataPassing {
    func passDataToItemDetail(source: ListDataStore, destination: inout ItemDetailDataStore) {
        destination.url = source.selectedItemURL
    }
}

extension TrackCollectionRouter: TrackCollectionRoutingLogic {
    func routeToItemDetail(url: URL) {
        guard let viewController = viewController,
            let itemDetailViewController = UIStoryboard(name: "ItemDetailViewController",
                                                        bundle: nil).instantiateInitialViewController() as? ItemDetailViewController
            else { return }
        
        if let dataStore = dataStore, var destinationDataStore = itemDetailViewController.router?.dataStore {
            passDataToItemDetail(source: dataStore, destination: &destinationDataStore)
        }
        navigateToSomewhere(source: viewController, destination: itemDetailViewController)
    }
}