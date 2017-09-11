//
//  ItemDetailInteractor.swift
//  CleanSwift
//
//  Created by Henry on 9/10/17.
//  Copyright (c) 2017 Henry Tsai. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ItemDetailBusinessLogic {
    func displayDetail(request: ItemDetail.DisplayDetail.Request)
}

protocol ItemDetailDataStore {
    var url: URL? { get set }
}

class ItemDetailInteractor  {
	var presenter: ItemDetailPresentationLogic?
    var url: URL?
}

extension ItemDetailInteractor: ItemDetailBusinessLogic {
    func displayDetail(request: ItemDetail.DisplayDetail.Request) {
        guard let url = url else {
            return
        }
        let response = ItemDetail.DisplayDetail.Response(url: url)
        presenter?.presentDetail(response: response)
    }
}

extension ItemDetailInteractor: ItemDetailDataStore { }
