//
//  PreviewViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

protocol PreviewViewControllerDelegate: class {

    func didTapMoreButton()

}

class PreviewViewController: UIViewController {

    // MARK: - Properties

    weak var delegate: PreviewViewControllerDelegate?
    var artist: Artist?
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 15.0
        if let unwrappedArtist = artist {
            configure(with: unwrappedArtist)
        }
    }

    // MARK: - IBActions

    @IBAction private func showMore(_ sender: Any) {
        delegate?.didTapMoreButton()
    }

    // MARK: - Configuration

    private func configure(with artist: Artist) {
        nameLabel.text = artist.name
        descriptionLabel.text = artist.description
    }

}
