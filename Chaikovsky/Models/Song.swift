//
//  Song.swift
//  Chaikovsky
//
//  Created by Алексей on 10/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

struct Song {

    var title: String
    var fileName: String

}

extension Song: Equatable { }

extension Song {

    static let demo = [
        Song(title: "Неаполитанская песенка", fileName: "p-i-chaykovskiy-neapolitanskaya-pesenka"),
        Song(title: "Валерий Гергиев и Денис Мацуев", fileName: "PromoTchaikovskyMatsuevGergiev"),
        Song(title: "RachDayssmall", fileName: "RachDayssmall"),
    ]

}
