//
//  DetailViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView
import ExpandableLabel

class DetailViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case bio
        case music
        case concerts
    }

    var artist = Artist()
    var stretchyHeader: ArtistHeaderView!

    @IBOutlet weak var siriButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibViews = Bundle.main.loadNibNamed(ArtistHeaderView.className, owner: self, options: nil)
        guard let header = nibViews?.first as? ArtistHeaderView else { return }
        header.artistImageView.image = UIImage(named: "\(artist.imageName)-header")
        stretchyHeader = header
        stretchyHeader.stretchDelegate = self
        stretchyHeader.minimumContentHeight = 0
        stretchyHeader.nameLabel.text = artist.name
        self.tableView.addSubview(self.stretchyHeader)
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
        setupNavigationBar()
        setupHeaders()
    }

    // MARK: - Private methods

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isHidden = false
    }

    private func setupHeaders() {
        let headerNib = UINib.init(nibName: DetailTableHeaderView.className, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: DetailTableHeaderView.className)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ConcertsTableViewController.className {
            if let destinationVC = segue.destination as? ConcertsTableViewController {
                destinationVC.artist = artist
            }
        }
    }

}

extension DetailViewController: UITableViewDelegate {

    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let musicCell = cell as? MusicTableViewCell {
            musicCell.playerController?.removeFromParent()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let enumSection = Section(rawValue: indexPath.section) else { return }
        switch enumSection {
        case .concerts:
            performSegue(withIdentifier: ConcertsTableViewController.className, sender: nil)
        default: return
        }
    }

}

extension DetailViewController: UITableViewDataSource {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailViewController.Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let enumSection = Section(rawValue: section) else { return 0 }
        switch enumSection {
        case .music:
            return artist.songs.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let enumSection = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch enumSection {
        case .bio:
            let cell: BioTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.bioLabel.text = artist.shortBio
            cell.bioLabel.delegate = self
            return cell
        case .music:
            let cell: MusicTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            guard let player = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AudioPlayerViewController.className) as? AudioPlayerViewController else { return UITableViewCell()}
            player.song = artist.songs[indexPath.row]
            cell.playerController = player
            addChild(player)
            cell.playerController?.didMove(toParent: self)
            player.view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
            if let playerView = player.view {
                cell.contentView.addSubview(playerView)
                playerView.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint(item: playerView, attribute: .leading, relatedBy: .equal, toItem: cell.contentView, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
                NSLayoutConstraint(item: playerView, attribute: .trailing, relatedBy: .equal, toItem: cell.contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
                NSLayoutConstraint(item: playerView, attribute: .top, relatedBy: .equal, toItem: cell.contentView, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
                NSLayoutConstraint(item: playerView, attribute: .bottom, relatedBy: .equal, toItem: cell.contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
            }
            return cell
        case .concerts:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Посмотреть все концерты"
            cell.textLabel?.textColor = .linkColor
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailTableHeaderView.className) as? DetailTableHeaderView {
            guard let enumSection = Section(rawValue: section) else { return nil }
            switch enumSection {
            case .bio:
                headerView.titleLabel.text =  "Биография"
            case .music:
                headerView.titleLabel.text =  "Композиции"
            case .concerts:
                headerView.titleLabel.text =  "Концерты"
            }
            return headerView
        }
        return nil
    }

}

extension DetailViewController: GSKStretchyHeaderViewStretchDelegate {

    func stretchyHeaderView(_ headerView: GSKStretchyHeaderView, didChangeStretchFactor stretchFactor: CGFloat) {
        headerView.isHidden = stretchFactor == 0.0
        if stretchFactor < 0.5 {
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
            navigationController?.navigationBar.tintColor = .linkColor
        } else {
            navigationController?.navigationBar.tintColor = .white
        }
    }

}

extension DetailViewController: ExpandableLabelDelegate {

    func didExpandLabel(_ label: ExpandableLabel) {
        tableView.endUpdates()
    }

    func didCollapseLabel(_ label: ExpandableLabel) { }


    func willExpandLabel(_ label: ExpandableLabel) {
        tableView.beginUpdates()
    }

    func willCollapseLabel(_ label: ExpandableLabel) { }

}
