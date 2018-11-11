//
//  ConcertsTableViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 11/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ConcertsTableViewController: UITableViewController {

    var artist: Artist? = nil
    var concerts: [Concert] = [Concert]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Private methods

    private func loadData() {
        NetworkService().playbill(composer: artist?.serverName) { (conc) in
            if let unwrappedConcerts = conc {
                self.concerts = unwrappedConcerts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return concerts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ConcertTableViewCell = tableView.dequeueReusableCell(for: indexPath)

        let concert = concerts[indexPath.row]
        cell.nameLabel.text = concert.title
        cell.membersLabel.text = concert.members
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "RU-ru")
        cell.dateLabel.text = formatter.string(from: concert.date)
        cell.designableView.backgroundColor = ColorHash(concert.title, [CGFloat(0.3)], [CGFloat(0.9)]).color
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ConcertTableViewController.className, sender: concerts[indexPath.row])
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ConcertTableViewController.className {
            if let destinationVC = segue.destination as? ConcertTableViewController, let concert = sender as? Concert {
                destinationVC.concert = concert
            }
        }
    }
}
