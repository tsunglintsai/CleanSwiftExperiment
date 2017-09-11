//
//  TrackCollectionViewCell.swift
//  CleanSwift
//
//  Created by Henry on 9/11/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    var imageURL: URL?
    @IBOutlet weak var squareImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}

extension TrackCollectionViewCell {
    func updateCell(with item: TrackCollectionViewController.ViewModel.Item) {
        imageURL = item.imageURL
        titleLabel.text = item.title
        subTitleLabel.text = item.subtitle
        guard let imageURL = imageURL else { return }
        squareImageView.image = nil
        squareImageView.layer.borderColor = UIColor.gray.cgColor
        squareImageView.layer.borderWidth = 0.5
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                if self.imageURL == imageURL {
                    self.squareImageView.image = image
                    self.squareImageView.layer.borderColor = nil
                    self.squareImageView.layer.borderWidth = 0
                }
            }
        }
    }
}
