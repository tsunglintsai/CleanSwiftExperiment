//
//  EntityManager.swift
//  CleanSwift
//
//  Created by Henry on 9/10/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

protocol EntityManager {
    func fetchUserData() -> UserData?
    func saveUserData(userData: UserData)
}

struct EntityManagerWithUserDefault {
    struct PersistenceKey {
        private(set) var keyName: String
        init(keyName: String) {
            self.keyName = keyName
        }
    }
    static let userIdKey = EntityManagerWithUserDefault.PersistenceKey(keyName: "userIdKey")
    static let accessTokenKey = EntityManagerWithUserDefault.PersistenceKey(keyName: "accessTokenKey")
    static let refreshTokenKey = EntityManagerWithUserDefault.PersistenceKey(keyName: "refreshTokenKey")
    fileprivate var userDefault = UserDefaults.standard
}

extension EntityManagerWithUserDefault: EntityManager {
    func fetchUserData() -> UserData? {
        guard let userId = userDefault.string(forKey: EntityManagerWithUserDefault.userIdKey.keyName) else { return nil }
        let accessToken = userDefault.string(forKey: EntityManagerWithUserDefault.accessTokenKey.keyName)
        let refreshToken = userDefault.string(forKey: EntityManagerWithUserDefault.refreshTokenKey.keyName)
        let result = UserData(userId: userId, accessToken: accessToken, refreshToken: refreshToken)
        return result
    }
    
    func saveUserData(userData: UserData) {
        let userId = userData.userId
        let accessToken = userData.accessToken
        let refreshToken = userData.refreshToken
        userDefault.set(userId, forKey: EntityManagerWithUserDefault.userIdKey.keyName)
        userDefault.set(accessToken, forKey: EntityManagerWithUserDefault.accessTokenKey.keyName)
        userDefault.set(refreshToken, forKey: EntityManagerWithUserDefault.refreshTokenKey.keyName)
        userDefault.synchronize()
    }
}
