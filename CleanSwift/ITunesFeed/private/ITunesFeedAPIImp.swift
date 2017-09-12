//
//  ITunesFeedAPIImp.swift
//  ITunesFeed
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation

protocol URLContertable {
    var url: URL? { get }
}

extension ITunesFeed.AppleMusic.Request {
    var url: URL? {
        return URL(string:"https://rss.itunes.apple.com/api/v1/us/apple-music/\(feedType.code)/\(limit)/explicit.json")
    }
}

struct ITunesFeedAPIImp: ITunesFeedAPIProtocol {
    var operationQueue = OperationQueue()
    init() {
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.qualityOfService = .default
    }

    func featchAppleMusicFeed(request: ITunesFeed.AppleMusic.Request, completion: @escaping (Result<ITunesFeed.Track>) -> Void) {
        guard let url = request.url else { return }
        let operation = BlockOperation {
            guard let data = try? Data(contentsOf: url),
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: Any]],
                let itemsDictionaray = json?["feed"]?["results"] as? [[String: Any]]
                else {
                    let response = Result<ITunesFeed.Track>.error(code: 0)
                    completion(response)
                    return
            }
            let items = itemsDictionaray.flatMap{ITunesFeed.Track(representation:$0)}
            let result = Result<ITunesFeed.Track>.success(list: items)
            completion(result)
        }
        operationQueue.addOperation(operation)
    }
}

protocol DictionaryInitializable {
    init?(representation:[String:Any])
}

extension ITunesFeed.Track: DictionaryInitializable {
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

