//
//  HomeViewController.swift
//  CleanSwift
//
//  Created by Henry on 9/10/17.
//  Copyright (c) 2017 Henry Tsai. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeDisplayLogic: class {
    func showListView()
}

class HomeViewController: UINavigationController {
	var interactor: HomeBusinessLogic?
	var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    init() {
        super.init(navigationBarClass: nil, toolbarClass: nil)
        setup()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  	// MARK: Setup
  	private func setup() {
	    let viewController = self
    	let interactor = HomeInteractor()
    	let presenter = HomePresenter()
    	let router = HomeRouter()
    	viewController.interactor = interactor
    	viewController.router = router
    	interactor.presenter = presenter
    	presenter.viewController = viewController
    	router.viewController = viewController
    	router.dataStore = interactor
    }
  
    // MARK: Routing
  	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    	if let scene = segue.identifier {
      		let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      		if let router = router, router.responds(to: selector) {
        		router.perform(selector, with: segue)
      		}
    	}
  	}
  
  	// MARK: View lifecycle
  	override func viewDidLoad() {
   		super.viewDidLoad()
    	initHome()
  	}
  
    func initHome(){
        let request = Home.InitHome.Request()
        interactor?.initHome(request: request)
    }
  
}

extension HomeViewController: HomeDisplayLogic {
    func showListView() {
        router?.routeToListView()
    }
}
