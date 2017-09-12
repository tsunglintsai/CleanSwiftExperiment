//
//  LoginInteractor.swift
//  BusinessLogic
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

public protocol LoginPresentationLogic {
    func loginSuccess()
}

public protocol LoginBusinessLogic {
    func login(request: Login.DoLogin.Request)
}

public protocol LoginDataStore {
}

public class LoginInteractor: LoginDataStore {
    public var presenter: LoginPresentationLogic?
    public var worker: PerformLoginWorker = PerformLoginWorker()
    public var entityManager: EntityManager?
    public init(entityManager: EntityManager) {
        self.entityManager = entityManager
    }
}

extension LoginInteractor: LoginBusinessLogic {
    public func login(request: Login.DoLogin.Request) {
        worker.performLogin(userId: request.userId, password: request.password) { [weak self] (success, accessToken, refreshToken) -> (Void) in
            if success {
                let userData = UserData(userId: request.userId, accessToken: accessToken, refreshToken: refreshToken)
                self?.entityManager?.saveUserData(userData: userData)
                self?.presenter?.loginSuccess()
            } else {
                print("--------")
            }
        }
    }
}
