//
//  ListInteractor.swift
//  BusinessLogic
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import Foundation
import ITunesFeed

public protocol ListBusinessLogic {
    func fetchData(request: List.FetchData.Request)
    func selectItme(itemId: String)
}

public protocol ListDataStore {
    var selectedItemURL: URL? { get set }
}

public protocol ListPresentationLogic {
    func presentList(list: [ITunesFeed.Track])
    func presentTrack(track: ITunesFeed.Track)
}

public class ListInteractor: ListDataStore {
    public var presenter: ListPresentationLogic?
    public var worker: ListWorker
    public var selectedItemURL: URL?
    public init(worker: ListWorker) {
        self.worker = worker
    }
}

extension ListInteractor: ListBusinessLogic {
    public func fetchData(request: List.FetchData.Request) {
        worker.delegate = self
        worker.fetchData()
    }
    
    public func selectItme(itemId: String) {
        guard let track = worker.result.first(where: { (track) -> Bool in
            track.trackId == itemId
        }) else { return }
        selectedItemURL = URL(string: track.detailURL)
        presenter?.presentTrack(track: track)
    }
}

extension ListInteractor: ListWorkerDelegate {
    public func didFetchedData() {
        presenter?.presentList(list: worker.result)
    }
}
