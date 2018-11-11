//
//  ConcertTableViewCell.swift
//  Chaikovsky
//
//  Created by Алексей on 11/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ConcertTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var designableView: DesignableView!

    // MARK: - Lifecucles
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
