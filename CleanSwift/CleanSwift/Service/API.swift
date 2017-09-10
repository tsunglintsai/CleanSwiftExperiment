//
//  API.swift
//  CleanSwift
//
//  Created by Henry on 9/10/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

struct APIAuth {
    enum Request {
        case new(userId: String, password: String)
        case refresh(userId: String, refreshToken: String)
    }
    enum Response<T> {
        case success(request: APIAuth.Request, result: T)
        case error(request: APIAuth.Request, code: Int)
    }
    
    struct Result {
        var refreshToken: String
        var accessToken: String
    }
}

protocol API {
    typealias AuthCompletion = (APIAuth.Response<APIAuth.Result>) -> Void
    func auth(request: APIAuth.Request, completion: @escaping AuthCompletion)
}

struct APIWithMock: API {
    func auth(request: APIAuth.Request, completion: @escaping AuthCompletion) {
        DispatchQueue.global().async {
            sleep(1)
            switch request {
            case .new(let userId, let password):
                if userId == "ring33" && password == "1234" {
                    let result = APIAuth.Result(refreshToken: "EFGH", accessToken: "ABCDE")
                    let response = APIAuth.Response.success(request: request, result: result)
                    completion(response)
                } else {
                    let response = APIAuth.Response<APIAuth.Result>.error(request: request, code: 400)
                    completion(response)
                }
            case .refresh(let userId, let refreshToken):
                if  userId == "ring33" && refreshToken == "EFGH" {
                    let result = APIAuth.Result(refreshToken: "EFGH", accessToken: "ABCDE")
                    let response = APIAuth.Response.success(request: request, result: result)
                    completion(response)
                } else {
                    let response = APIAuth.Response<APIAuth.Result>.error(request: request, code: 400)
                    completion(response)
                }
            }
        }
    }
}
