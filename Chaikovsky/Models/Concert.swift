//
//  Concert.swift
//  Chaikovsky
//
//  Created by Алексей on 11/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

struct Concert {

    var title: String
    var date: Date = Date()
    var hall: String = ""
    var buyUrl: String = ""
    var program: String = ""
    var site: String = ""
    var photo: String = ""
    var members: String = ""

}

extension Concert: Decodable {

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case date = "дата, гггг-мм-дд"
        case hall = "зал"
        case buyUrl = "купить билет"
        case program = "программа"
        case site = "ссылка на сайт филармонии"
        case photo = "ссылки на фото участников"
        case members = "участники"

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title: String = try container.decode(String.self, forKey: .title)
        let dateDouble: Double = try container.decode(Double.self, forKey: .date)
        let date = Date(timeIntervalSince1970: dateDouble / 1000)
        let hall: String = try container.decode(String.self, forKey: .hall)
        let buyUrl: String = try container.decode(String.self, forKey: .buyUrl)
        let program: String = try container.decode(String.self, forKey: .program)
        let site: String = try container.decode(String.self, forKey: .site)
        let photo: String = try container.decode(String.self, forKey: .photo)
        let members: String = try container.decode(String.self, forKey: .members)

        self.init(title: title, date: date, hall: hall, buyUrl: buyUrl, program: program, site: site, photo: photo, members: members)
    }

}
