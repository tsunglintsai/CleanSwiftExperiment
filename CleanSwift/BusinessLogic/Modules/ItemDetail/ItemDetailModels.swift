//
//  ItemDetailModels.swift
//  CleanSwift
//
//  Created by Henry on 9/10/17.
//  Copyright (c) 2017 Henry Tsai. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

public enum ItemDetail {
	public enum DisplayDetail {
		public struct Request {
            public init() { }
        }
    	public struct Response {
            public let url: URL
        }
  	}
}
