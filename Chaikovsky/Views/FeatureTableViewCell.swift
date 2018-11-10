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

    @IBOutlet private weak var designableView: DesignableView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        pictureView.layer.masksToBounds = true
        pictureView.layer.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Cell configuration

    func configure(title: String, color: UIColor, image: UIImage? = nil) {
        titleLabel.text = title
        designableView.backgroundColor = color
        pictureView.image = image
    }

}
