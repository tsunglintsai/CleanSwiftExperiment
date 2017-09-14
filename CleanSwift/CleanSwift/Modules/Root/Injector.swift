//
//  Builder.swift
//  CleanSwift
//
//  Created by Henry on 9/13/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation
import BusinessLogic

public protocol InjectorProtocol {
    mutating func add<T>(instance: T, for type: T.Type)
    func getInstance<T>(for type: T.Type) -> T?
}

class Injector: InjectorProtocol {
    private var pool = [String: Any]()
    func add<T>(instance: T, for type: T.Type) {
        let className = String(describing: T.self)
        pool[className] = instance
    }
    func getInstance<T>(for type: T.Type) -> T? {
        let className = String(describing: T.self)
        return pool[className] as? T
    }
}
