//
//  API.swift
//  API
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

public struct APIAuth {
    public enum Request {
        case new(userId: String, password: String)
        case refresh(userId: String, refreshToken: String)
    }
    public enum Response<T> {
        case success(request: APIAuth.Request, result: T)
        case error(request: APIAuth.Request, code: Int)
    }
    
    public struct Result {
        public var refreshToken: String
        public var accessToken: String
    }
}

public protocol API {
    typealias AuthCompletion = (APIAuth.Response<APIAuth.Result>) -> Void
    func auth(request: APIAuth.Request, completion: @escaping AuthCompletion)
}

public struct APIFactory {
    public static func createAPI() -> API {
        return APIWithMock()
    }
}


