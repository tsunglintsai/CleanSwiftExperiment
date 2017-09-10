//
//  ListPresenter.swift
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

protocol ListPresentationLogic
{
  func presentSomething(response: List.Something.Response)
}

class ListPresenter: ListPresentationLogic
{
  weak var viewController: ListDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: List.Something.Response)
  {
    let viewModel = List.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
