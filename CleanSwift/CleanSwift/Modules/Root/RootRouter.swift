//
//  RootRouter.swift
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

@objc protocol RootRoutingLogic {
    func routeToLogin()
    func routeToMain()
}

protocol RootDataPassing {
	var dataStore: RootDataStore? { get }
}

class RootRouter: NSObject, RootDataPassing {
	weak var viewController: RootViewController?
	var dataStore: RootDataStore?
    
    func removeAllChildViewControllers() {
        viewController?.childViewControllers.forEach({ (viewController) in
            viewController.willMove(toParentViewController: nil)
            viewController.view.removeFromSuperview()
        })
    }
    
    func addChildViewController(childViewController: UIViewController) {
        guard let viewContoller = viewController else { return }
        childViewController.view.frame = viewContoller.view.bounds
        childViewController.willMove(toParentViewController: viewController)
        viewContoller.addChildViewController(childViewController)
        viewContoller.view.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: viewContoller)
    }
 }

extension RootRouter: RootRoutingLogic {
    func routeToLogin() {
        removeAllChildViewControllers()
        let loginViewController = LoginViewController(routerDelegate: self)
        addChildViewController(childViewController: loginViewController)
    }
    
    func routeToMain() {
        removeAllChildViewControllers()
        let tabNavigationController = TabNavigationViewController(nibName: nil, bundle: nil)
        addChildViewController(childViewController: tabNavigationController)
    }
}

extension RootRouter: LoginRouterDelegate {
    func loginSuccess() {
        routeToMain()
    }
}