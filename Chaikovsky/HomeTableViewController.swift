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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeatureTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        switch indexPath.row {
        case 0:
            cell.configure(title: "AR", color: .orange)
        case 1:
            cell.configure(title: "Music", color: .green)
        case 2:
            cell.configure(title: "Bio", color: .yellow)
        default:
            cell.configure(title: "Tickets", color: .blue)
        }
        return cell
    }

}
