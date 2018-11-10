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

    enum Section: Int, CaseIterable {
        case bio
        case music
        case video
        case concerts
    }

    var artist = Artist()
    var stretchyHeader: ArtistHeaderView!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibViews = Bundle.main.loadNibNamed(ArtistHeaderView.className, owner: self, options: nil)
        guard let header = nibViews?.first as? ArtistHeaderView else { return }
        stretchyHeader = header
        stretchyHeader.stretchDelegate = self
        stretchyHeader.minimumContentHeight = 0
        stretchyHeader.nameLabel.text = artist.name
        self.tableView.addSubview(self.stretchyHeader)
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
        setupNavigationBar()

    }

    // MARK: - Private methods

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationItem.leftBarButtonItem?.tintColor = .white
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailViewController.Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let enumSection = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch enumSection {
        case .bio:
            let cell: BioTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.bioLabel.text = artist.shortBio
            return cell
        case .music:
            let cell: MusicTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textLabel?.text = "Музыка"
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let enumSection = Section(rawValue: section) else { return nil }
        switch enumSection {
        case .bio:
            return "Биография"
        case .music:
            return "Композиции"
        case .video:
            return "Видео"
        case .concerts:
            return "Концерты"
        }
    }

}

extension DetailViewController: GSKStretchyHeaderViewStretchDelegate {

    func stretchyHeaderView(_ headerView: GSKStretchyHeaderView, didChangeStretchFactor stretchFactor: CGFloat) {
        headerView.isHidden = stretchFactor == 0.0
        if stretchFactor < 0.5 {
            print(stretchFactor)
            self.navigationItem.title = artist.name
            let factor = stretchFactor < 0 ? 0.0 : stretchFactor
            let color = UIColor(white: 1.0, alpha: 1.0 - pow((factor * 2.0), 2))
            navigationController?.navigationBar.setBackgroundImage(UIImage(color: color), for: UIBarMetrics.default)
            self.stretchyHeader.nameLabel.alpha = pow((stretchFactor * 2.0), 2)
        } else {
            self.navigationItem.title = nil
            navigationController?.view.backgroundColor = .clear
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

            self.stretchyHeader.nameLabel.alpha = 1.0
        }

        if stretchFactor < 0.3 {
            navigationItem.leftBarButtonItem?.tintColor = .blue
        } else {
            navigationItem.leftBarButtonItem?.tintColor = .white
        }
    }

}
