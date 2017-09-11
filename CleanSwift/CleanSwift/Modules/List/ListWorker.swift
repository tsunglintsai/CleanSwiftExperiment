//
//  ListWorker.swift
//  CleanSwift
//
//  Created by Henry on 9/9/17.
//  Copyright (c) 2017 Henry Tsai. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListWorkerDelegate: class {
    func didFetchedData()
}

class ListWorker {
    var api: MusicAPI = MusicAPIImp()
    var result = [MusicAPIFeed.Track]()
    weak var delegate: ListWorkerDelegate?
    func fetchData() {
        let request = MusicAPIFeed.Request(feedType: FeedType.hotTracks)
        api.getTopResult(with: request) { [weak self] (response: MusicAPIFeed.Response<MusicAPIFeed.Track>) in
            switch response {
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


