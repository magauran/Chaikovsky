//
//  BioTableViewCell.swift
//  Chaikovsky
//
//  Created by Алексей on 10/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import ExpandableLabel

class BioTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak var bioLabel: ExpandableLabel!

    // MARK: - Lifecyle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupBioLabel()
    }

    // MARK: - Private methods

    private func setupBioLabel() {
        bioLabel.numberOfLines = 5
        bioLabel.collapsed = true
        let moreString = NSAttributedString(string: "Показать полностью...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.linkColor])
        bioLabel.collapsedAttributedLink = moreString
        bioLabel.ellipsis = nil
    }

}
