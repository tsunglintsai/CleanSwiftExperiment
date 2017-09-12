//
//  ListWorker.swift
//  BusinessLogic
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation
import ITunesFeed

public protocol ListWorkerDelegate: class {
    func didFetchedData()
}

public class ListWorker {
    public var api: ITunesFeedAPIProtocol = ITunesFeed.createAPI()
    public var result = [ITunesFeed.Track]()
    public weak var delegate: ListWorkerDelegate?
    public init() { }
    public func fetchData() {
        let request = ITunesFeed.AppleMusic.Request(feedType: ITunesFeed.AppleMusic.FeedType.hotTracks)
        api.featchAppleMusicFeed(request: request) { [weak self] (result) in
            switch result {
            case .error:
                break
            case .success(let result):
                self?.result = result
                self?.delegate?.didFetchedData()
                break
            }
        }
    }
}


