//
//  ITunesFeedProtocol.swift
//  ITunesFeed
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

public struct ITunesFeed {
    public struct Country {
        let code: String
        init(code: String){
            self.code = code
        }
        public static let UnitedStates = ITunesFeed.Country(code: "us")
        public static let Taiwan = ITunesFeed.Country(code: "tw")
    }
    public struct AppleMusic {
        public struct Request {
            public let feedType: AppleMusic.FeedType
            public let contry: Country
            public let limit: Int
            public init(feedType: ITunesFeed.AppleMusic.FeedType, contry: Country = .UnitedStates, limit: Int = 100) {
                self.feedType = feedType
                self.contry = contry
                self.limit = limit
            }
        }
        public struct FeedType {
            let code: String
            init(code: String) {
                self.code = code
            }
            public static let hotTracks = FeedType(code: "hot-tracks")
            public static let hotTracksCountry = FeedType(code: "hot-tracks-country")
        }
    }
    public struct Track {
        public let artistName: String
        public let name: String
        public let artWorkURL: String
        public let detailURL: String
        public let trackId: String
    }
}

public protocol ITunesFeedAPIProtocol {
    func featchAppleMusicFeed(request: ITunesFeed.AppleMusic.Request, completion: @escaping (Result<ITunesFeed.Track>) -> Void)
}

public extension ITunesFeed {
    static func createAPI() -> ITunesFeedAPIProtocol {
        return ITunesFeedAPIImp()
    }
}

