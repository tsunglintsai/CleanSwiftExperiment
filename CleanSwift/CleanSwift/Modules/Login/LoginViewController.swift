//
//  LoginViewController.swift
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

protocol LoginDisplayLogic: class {
    func loginSuccess()
}

class LoginViewController: UIViewController {
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic)?
    @IBOutlet weak var userIdField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    init(routerDelegate: LoginRouterDelegate?) {
        super.init(nibName: "LoginView", bundle: nil)
        setup(routerDelegate: routerDelegate)
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
    private func setup(routerDelegate: LoginRouterDelegate? = nil) {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        router.delegate = routerDelegate
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    @IBAction func didTapLoginButton(_ sender: Any) {
        guard let userId = userIdField.text, let password = passwordField.text else { return }
        let request = Login.DoLogin.Request(userId: userId, password: password)
        interactor?.login(request: request)
    }
}

extension LoginViewController: LoginDisplayLogic {
    func loginSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.router?.loginSuccess()
        }
    }
}
