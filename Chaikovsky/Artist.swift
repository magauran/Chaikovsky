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

    init() {
        self.name = ""
        self.description = ""
        self.imageName = ""
    }

    init(name: String, description: String) {
        self.name = name
        self.description = description
        self.imageName = name
    }

}
