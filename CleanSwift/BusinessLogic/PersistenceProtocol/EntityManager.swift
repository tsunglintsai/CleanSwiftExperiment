//
//  EntityManager.swift
//  BusinessLogic
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

public protocol EntityManager {
    func fetchUserData() -> UserData?
    func saveUserData(userData: UserData)
}
