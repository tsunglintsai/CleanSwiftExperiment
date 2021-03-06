//
//  ListViewController.swift
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
import BusinessLogic

protocol ListDisplayLogic: class {
    func displayList(viewModel: ListViewController.ViewModel)
    func displayItemDetail(url: URL)
}

extension ListViewController {
    struct ViewModel {
        struct Item {
            var itemId: String
            var title: String
            var subtitle: String
            var imageURL: URL?
        }
        private(set) var items: [Item]
    }
}

class ListViewController: UITableViewController {
    var interactor: ListBusinessLogic?
    var router: (NSObjectProtocol & ListRoutingLogic & ListDataPassing)?
    var viewModel: ViewModel = ViewModel(items: [ViewModel.Item]()) {
        didSet {
            tableView.reloadData()
        }
    }
}

extension ListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListViewCell
            else { return UITableViewCell() }
        let cellModel = viewModel.items[indexPath.row]
        cell.updateCell(with: cellModel)
        return cell
    }
}

extension ListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.row]
        interactor?.selectItme(itemId: item.itemId)
    }
}

extension ListViewCell {
    func updateCell(with item: ListViewController.ViewModel.Item) {
        imageURL = item.imageURL
        mainLabel.text = item.title
        subTitleLabel.text = item.subtitle
        guard let imageURL = imageURL else { return }
        squareImageView.image = nil
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                if self.imageURL == imageURL {
                    self.squareImageView.image = image
                }
            }
        }
    }
}

// MARK: View lifecycle
extension ListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = List.FetchData.Request()
        interactor?.fetchData(request: request)
    }
}

extension ListViewController: ListDisplayLogic {
    func displayList(viewModel: ListViewController.ViewModel) {
        self.viewModel = viewModel
    }
    
    func displayItemDetail(url: URL) {
        router?.routeToItemDetail(url: url)
    }
}
