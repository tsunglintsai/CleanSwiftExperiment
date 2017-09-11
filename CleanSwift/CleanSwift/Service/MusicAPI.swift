//
//  MusicAPI.swift
//  CleanSwift
//
//  Created by Henry on 9/10/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

enum FeedType {
    case hotTracks
}

protocol MusicAPI {
    func getTopResult<T: DictionaryInitializable>(with request: MusicAPIFeed.Request, completion: @escaping (MusicAPIFeed.Response<T>)->Void)
}

protocol DictionaryInitializable {
    init?(representation:[String:Any])
}

extension MusicAPIFeed.Track: DictionaryInitializable {
    init?(representation:[String: Any]) {
        guard let artistName = representation["artistName"] as? String,
            let name = representation["name"] as? String,
            let artWorkURL = representation["artworkUrl100"] as? String,
            let detailURL = representation["url"] as? String,
            let trackId = representation["id"] as? String
            else { return nil }
        self.artistName = artistName
        self.name = name
        self.artWorkURL = artWorkURL
        self.detailURL = detailURL
        self.trackId = trackId
    }
}

struct MusicAPIFeed {
    struct Request {
        let feedType: FeedType
    }
    enum Response<T> {
        case success(result:[T])
        case error()
    }
    struct Track {
        let artistName: String
        let name: String
        let artWorkURL: String
        let detailURL: String
        let trackId: String
    }
}

fileprivate extension FeedType {
    var feedPath: String {
        switch self {
        case .hotTracks:
            return "hot-tracks"
        }
    }
}

struct MusicAPIImp {
    var operationQueue = OperationQueue()
    struct Path {
        let path: URL
        static let prefix = "https://rss.itunes.apple.com/api/v1/us/apple-music/"
        static let suffix = "/200/explicit.json"
        init(feedType: FeedType) {
            let pathString = "\(Path.prefix)\(feedType.feedPath)\(Path.suffix)"
            path = URL(string: pathString)!
        }
    }
    init() {
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.qualityOfService = .default
    }
}

extension MusicAPIImp: MusicAPI {
    func getTopResult<T: DictionaryInitializable>(with request: MusicAPIFeed.Request, completion: @escaping (MusicAPIFeed.Response<T>)->Void) {
        let path = MusicAPIImp.Path(feedType: request.feedType)
        let operation = BlockOperation {
            guard let data = try? Data(contentsOf: path.path),
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: Any]],
                let itemsDictionaray = json?["feed"]?["results"] as? [[String: Any]]
            else {
                let response = MusicAPIFeed.Response<T>.error()
                completion(response)
                return
            }
            let items = itemsDictionaray.flatMap{T(representation:$0)}
            let response = MusicAPIFeed.Response<T>.success(result: items)
            completion(response)
        }
        operationQueue.addOperation(operation)
    }
}
