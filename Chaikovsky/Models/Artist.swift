//
//  Artist.swift
//  Chaikovsky
//
//  Created by Алексей on 10/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

class Artist {

    let name: String
    let description: String
    let imageName: String
    let shortBio: String
    let bio: String = ""

    init() {
        self.name = ""
        self.description = ""
        self.imageName = ""
        self.shortBio = ""
    }

    init(name: String, description: String) {
        self.name = name
        self.description = description
        self.imageName = name
        self.shortBio = ""
    }

    init(imageName: String) {
        switch imageName {
        case "rakhmaninov":
            self.shortBio = """
            Сергей Васильевич Рахманинов (1 апреля (20 марта) 1873 — 28 марта 1943) — русский
            композитор, пианист и дирижёр.

            Синтезировал в своем творчестве принципы петербургской и московской композиторских школ (а также традиции западноевропейской музыки) и создал свой оригинальный стиль, оказавший впоследствии влияние как на русскую, так и на мировую музыку XX века.
            """
            self.name = "Рахманинов С. В."
            self.description = "Русский композитор, пианист, дирижёр"
            self.imageName = imageName
        default:
            self.shortBio = """
            Петр Ильич Чайковский родился 7 мая 1840 года в поселке Воткинск, расположенном на территории современной Удмуртии. Его отцом стал Илья Петрович Чайковский, инженер, происходящий от казачьего рода Чаек, известного в Украине. Матерью будущего прославленного композитора стала Александра Андреевна Ассиер, прошедшая обучение в Училище женских сирот незадолго до смерти отца. Александра Андреевна была обучена литературе, географии, арифметике, риторике и иностранным языкам.
            """
            self.name = "Чайковский"
            self.description = "Великий русский композитор"
            self.imageName = imageName
        }
    }

}