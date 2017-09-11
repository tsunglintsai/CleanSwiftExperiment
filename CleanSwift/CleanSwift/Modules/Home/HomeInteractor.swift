//
//  HomeInteractor.swift
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

protocol HomeBusinessLogic {
    func initHome(request: Home.InitHome.Request)
}

protocol HomeDataStore {
	//var name: String { get set }
}

class HomeInteractor: HomeDataStore {
	var presenter: HomePresentationLogic?
}

extension HomeInteractor: HomeBusinessLogic {
    // MARK: Do something
    func initHome(request: Home.InitHome.Request) {
        let response = Home.InitHome.Response()
        presenter?.showView(responder: response)
    }
}