//
//  UserData.swift
//  CleanSwift
//
//  Created by Henry on 9/10/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

public struct UserData {
    public var userId: String
    public var accessToken: String?
    public var refreshToken: String?
    public init(userId: String, accessToken: String?, refreshToken: String?) {
        self.userId = userId
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

