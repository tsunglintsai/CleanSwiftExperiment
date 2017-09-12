//
//  LoginModels.swift
//  BusinessLogic
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

public enum Login {
    // MARK: Use cases
    public enum DoLogin {
        public struct Request {
            public let userId: String
            public let password: String
            public init(userId: String, password: String) {
                self.userId = userId
                self.password = password
            }
        }
        public struct Response {
            public var success: Bool
        }
    }
}
