//
//  Result.swift
//  ITunesFeed
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(list:[T])
    case error(code:Int)
}
