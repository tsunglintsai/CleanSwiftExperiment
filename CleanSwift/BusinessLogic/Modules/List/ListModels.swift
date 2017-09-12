//
//  ListModels.swift
//  BusinessLogic
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation
import ITunesFeed

public enum List {
    public enum FetchData {
        public struct Request {
            public init() {}
        }
        public struct Response {
            public var tracks: [ITunesFeed.Track]
        }
    }
}
