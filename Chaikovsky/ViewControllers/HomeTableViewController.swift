//
//  HomeTableViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chaikovsky"
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
        //extendedLayoutIncludesOpaqueBars = false
        //tableView.contentOffset = HomeTableViewController.initialContentOffset
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeatureTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        switch indexPath.row {
        case 0:
            cell.configure(title: "", color: .clear, image: UIImage(named: "arcell"))
        case 1:
            cell.configure(title: "Siri", color: .green)
        case 2:
            cell.configure(title: "Bio", color: .yellow)
        default:
            cell.configure(title: "Tickets", color: .blue)
        }
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: RecognizerViewController.className, sender: nil)
        case 1:
            performSegue(withIdentifier: SiriViewController.className, sender: nil)
        default:
            print(":)")
        }
    }

}
