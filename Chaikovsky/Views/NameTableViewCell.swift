//
//  NameTableViewCell.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet private weak var nameLabel: UILabel!

    // MARK: - Cell configuration

    func configure(name: String) {
        nameLabel.text = name
    }

}
