//
//  FeatureTableViewCell.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak private var designableView: DesignableView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var pictureView: UIImageView!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        pictureView.layer.masksToBounds = true
        pictureView.layer.cornerRadius = 15.0
    }

    // MARK: - Cell configuration

    func configure(title: String = "", color: UIColor = .clear, image: UIImage? = nil) {
        titleLabel.text = title
        designableView.backgroundColor = color
        pictureView.image = image
    }

}
