//
//  RootInteractor.swift
//  CleanSwift
//
//  Created by Henry on 9/10/17.
//  Copyright (c) 2017 Henry Tsai. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

public protocol RootPresentationLogic {
    func presentView(response: Root.InitApplication.Response)
}

public protocol RootBusinessLogic {
    func initApplication(request: Root.InitApplication.Request)
}

public protocol RootDataStore { }

public class RootInteractor: RootDataStore {
	public var presenter: RootPresentationLogic?
    fileprivate var entityManager: EntityManager?
    fileprivate var currenUser: UserData?
    fileprivate let performLogin = PerformLoginWorker()
    public init(entityManager: EntityManager) {
        self.entityManager = entityManager
    }
}

extension RootInteractor {
    func showMain() {
        let response = Root.InitApplication.Response(isUsesrLogin: true)
        presenter?.presentView(response: response)
    }
    
    func showLogin() {
        let response = Root.InitApplication.Response(isUsesrLogin: false)
        presenter?.presentView(response: response)
    }
    
    func performLogin(completion: @escaping (Bool)-> Void) {
        guard let userData = currenUser,
            let refreshToken = userData.refreshToken
            else {
                completion(false)
                return
        }
        performLogin.performReauth(userId: userData.userId,
                                   refreshToken: refreshToken)
        { [weak self]  (success, accessToken, refreshToken) -> (Void) in
            if success {
                let newUserData = UserData(userId: userData.userId, accessToken: accessToken, refreshToken: refreshToken)
                self?.entityManager?.saveUserData(userData: newUserData)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

extension RootInteractor: RootBusinessLogic {
    public func initApplication(request: Root.InitApplication.Request) {
        Promise.firstOnMainQueue { [weak self] completion in
            // get user data
            self?.currenUser = self?.entityManager?.fetchUserData()
            completion(Promise.Resolution.fulfilled)
        }.thenOnMainQueue { [weak self] completion in
            self?.performLogin(completion: { (success) in
                if success {
                    completion(Promise.Resolution.fulfilled)
                } else {
                    completion(Promise.Resolution.rejected(NSError(domain: "", code: 0, userInfo: nil)))
                }
            })
        }.fail { [weak self] (error) in
            // if user isn't login show login
            self?.showLogin()
        }.done { [weak self] in
            // if user has login show main module
            self?.showMain()
        }.run()
    }
}
