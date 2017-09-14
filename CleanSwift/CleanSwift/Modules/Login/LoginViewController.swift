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
import BusinessLogic
import Persistence

protocol LoginDisplayLogic: class {
    func loginSuccess()
}

class LoginViewController: UIViewController {
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic)?
    @IBOutlet weak var userIdField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

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
