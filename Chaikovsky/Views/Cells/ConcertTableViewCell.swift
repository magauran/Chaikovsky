//
//  ConcertTableViewCell.swift
//  Chaikovsky
//
//  Created by Алексей on 11/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ConcertTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var designableView: DesignableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
