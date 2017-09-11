//
//  ListViewCell.swift
//  CleanSwift
//
//  Created by Henry on 9/10/17.
//  Copyright © 2017 Henry Tsai. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
    var imageURL: URL?
    @IBOutlet weak var squareImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}
