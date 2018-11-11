//
//  HomeTableViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case ar
        case siri
        case vk
        case concerts
    }

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chaikovsky"
        setupHeaders()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - IBActions

    @IBAction
    func unwindToHomeViewController(segue: UIStoryboardSegue) { }

    // MARK: - Private methods

    private func setupHeaders() {
        let headerNib = UINib.init(nibName: DetailTableHeaderView.className, bundle: nil)

        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: DetailTableHeaderView.className)
    }

}

extension HomeViewController: UITableViewDataSource {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeatureTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard let enumSection = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch enumSection {
        case .ar:
            cell.configure(image: UIImage(named: "arCell"))
        case .siri:
            cell.configure(image: UIImage(named: "siriCell"))
        case .vk:
            cell.configure(image: UIImage(named: "vkCell"))
        case .concerts:
            cell.configure(image: UIImage(named: "concertCell"))
        }

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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

}

extension HomeViewController: UITableViewDelegate {

    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let enumSection = Section(rawValue: indexPath.section) else { return }
        switch enumSection {
        case .ar:
            performSegue(withIdentifier: RecognizerViewController.className, sender: nil)
        case .siri:
            performSegue(withIdentifier: SiriViewController.className, sender: nil)
        case .vk:
            let url = URL(string: "vk://vk.com/im?sel=-173731650")!
            UIApplication.shared.open(url, options: [:])
        case .concerts:
            performSegue(withIdentifier: ConcertsTableViewController.className, sender: nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
}
