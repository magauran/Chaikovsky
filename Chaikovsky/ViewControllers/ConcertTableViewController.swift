//
//  ConcertTableViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 11/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ConcertTableViewController: UITableViewController {

    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var programLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hallLabel: UILabel!
    @IBOutlet weak var ticketLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!

    var concert: Concert? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        if let unwrappedConcert = concert {
            nameLabel.text = unwrappedConcert.title
            programLabel.text = unwrappedConcert.program
            membersLabel.text = unwrappedConcert.members
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            dateFormatter.locale = Locale(identifier: "RU-ru")
            dateLabel.text = dateFormatter.string(from: unwrappedConcert.date)
            hallLabel.text = unwrappedConcert.hall
            ticketLabel.text = "Билеты на данный концерт можно купить онлайн."
        }

        buyButton.layer.cornerRadius = 15.0
        calendarButton.layer.cornerRadius = 15.0
    }

    @IBAction func buy(_ sender: Any) {
        guard let urlString = concert?.buyUrl else { return }
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:])
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
