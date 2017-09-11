//
//  TrackCollectionPresenter.swift
//  CleanSwift
//
//  Created by Henry on 9/11/17.
//  Copyright (c) 2017 Henry Tsai. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class TrackCollectionPresenter: ListPresentationLogic {
	weak var viewController: TrackCollectionDisplayLogic?
  
    func presentList(response: List.FetchData.Response) {
        DispatchQueue.main.async { [weak self] in
            let viewModel = TrackCollectionViewController.ViewModel(items: response.tracks.flatMap{$0.toItem()})
            self?.viewController?.displayList(viewModel: viewModel)
        }
    }
    func presentTrack(track: MusicAPIFeed.Track) {
        guard let itemDetailURL = URL(string: track.detailURL) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayItemDetail(url: itemDetailURL)
        }
    }
}

extension MusicAPIFeed.Track {
    func toItem() -> TrackCollectionViewController.ViewModel.Item? {
        return TrackCollectionViewController.ViewModel.Item(itemId: trackId, title: name, subtitle: artistName, imageURL: URL(string: artWorkURL))
    }
}