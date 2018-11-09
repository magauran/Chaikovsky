//
//  PreviewViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    // MARK: - Properties

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
        print("more")
    }

    // MARK: - Configuration

    private func configure(with artist: Artist) {
        nameLabel.text = artist.name
        descriptionLabel.text = artist.description
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
