//
//  DetailViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView

class DetailViewController: UIViewController {

    var artist = Artist()
    var stretchyHeader: ArtistHeaderView!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibViews = Bundle.main.loadNibNamed(ArtistHeaderView.className, owner: self, options: nil)
        guard let header = nibViews?.first as? ArtistHeaderView else { return }
        self.stretchyHeader = header
        self.tableView.addSubview(self.stretchyHeader)
            if #available(iOS 11.0, *) {
                self.tableView.contentInsetAdjustmentBehavior = .never
            }
    }

}

extension DetailViewController: UITableViewDelegate {

    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension DetailViewController: UITableViewDataSource {

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: NameTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(name: artist.name)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PortraitTableViewCell", for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }

}
