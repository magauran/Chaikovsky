//
//  HomeTableViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    enum Section: Int, CaseIterable {
        case ar
        case siri
        case vk
        case concerts
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chaikovsky"
        setupHeaders()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationController()
    }

    // MARK: - IBActions

    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue) { }

    // MARK: - Private methods

    private func setupNavigationController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: .white), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UINavigationBar().shadowImage
    }

    private func setupHeaders() {
        let headerNib = UINib.init(nibName: DetailTableHeaderView.className, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: DetailTableHeaderView.className)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeatureTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard let enumSection = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch enumSection {
        case .ar:
            cell.configure(image: UIImage(named: "arCell"))
        case .siri:
            cell.configure(image: UIImage(named: "siriCell"))
        case .vk:
            cell.configure(title: "VK", color: .yellow)
        case .concerts:
            cell.configure(title: "Tickets", color: .blue)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailTableHeaderView.className) as? DetailTableHeaderView {
            guard let enumSection = Section(rawValue: section) else { return nil }
            switch enumSection {
            case .ar:
                headerView.titleLabel.text =  "AR-квест"
            case .siri:
                headerView.titleLabel.text =  "Умный голосовой помощник"
            case .vk:
                headerView.titleLabel.text =  "Бот ВКонтакте"
            case .concerts:
                headerView.titleLabel.text =  "Концерты"
            }
            return headerView
        }
        return nil
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let enumSection = Section(rawValue: indexPath.section) else { return }
        switch enumSection {
        case .ar:
            performSegue(withIdentifier: RecognizerViewController.className, sender: nil)
        case .siri:
            performSegue(withIdentifier: SiriViewController.className, sender: nil)
        case .vk:
            print(":)")
        case .concerts:
            performSegue(withIdentifier: ConcertsTableViewController.className, sender: nil)
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

}
