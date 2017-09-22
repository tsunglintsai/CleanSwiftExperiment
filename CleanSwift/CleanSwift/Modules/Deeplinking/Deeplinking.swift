//
//  Deeplinking.swift
//  CleanSwift
//
//  Created by Henry on 9/20/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

enum Deeplinking {
    case detail(itemId: String)
    case list
    case collection
}

extension Deeplinking {
    init?(url: URL) {
        guard let urlCompoenents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let firtsPathComponent = urlCompoenents.path.split(separator: "/").first
            else { return nil }
        let pathComponents = urlCompoenents.path.split(separator: "/").map{String($0)}
        print(pathComponents)
        switch firtsPathComponent {
        case "detail":
            guard pathComponents.count > 1 else { return nil }
            self = Deeplinking.detail(itemId: pathComponents[1])
        case "list":
            self = Deeplinking.list
        case "collection":
            self = Deeplinking.collection
        default:
            return nil
        }
    }
}
