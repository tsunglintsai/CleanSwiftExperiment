//
//  PerformLoginWorker.swift
//  BusinessLogic
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation
import API

public class PerformLoginWorker {
    public init() { }
    private(set) var api: API = APIFactory.createAPI()
    public func performReauth(userId: String, refreshToken: String, completion: @escaping (Bool, String?, String?)->(Void)) {
        print("login in ....")
        let request = APIAuth.Request.refresh(userId: userId, refreshToken: refreshToken)
        api.auth(request: request) { (result) in
            switch result {
            case .success( _, let result):
                completion(true, result.accessToken, result.refreshToken)
                break
            case .error(_, _):
                completion(false, nil, nil)
                break
            }
            print("done login in")
        }
    }
    
    public func performLogin(userId: String, password: String, completion: @escaping (Bool, String?, String?)->(Void)) {
        let request = APIAuth.Request.new(userId: userId, password: password)
        api.auth(request: request) { (result) in
            switch result {
            case .success( _, let result):
                completion(true, result.accessToken, result.refreshToken)
                break
            case .error( _, _):
                completion(false, nil, nil)
                break
            }
        }
    }
}
