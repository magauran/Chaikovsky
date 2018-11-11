//
//  ColorHash.swift
//  Chaikovsky
//
//  Created by Алексей on 11/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ColorHash {
    private let seed = CGFloat(131.0)
    private let seed2 = CGFloat(137.0)
    private let maxSafeInteger = 9007199254740991.0 / seed2
    private let defaultLS = [CGFloat(0.35), CGFloat(0.5), CGFloat(0.65)]
    private let full = CGFloat(360.0)

    private(set) var str: String
    private(set) var brightness: [CGFloat]
    private(set) var saturation: [CGFloat]

    init(_ str: String, _ saturation: [CGFloat] = defaultLS, _ brightness: [CGFloat] = defaultLS) {
        self.str = str
        self.saturation = saturation
        self.brightness = brightness
    }

    var bkdrHash: CGFloat {
        var hash = CGFloat(0)
        for char in "\(str)x".characters {
            if let scl = String(char).unicodeScalars.first?.value {
                if hash > maxSafeInteger {
                    hash = hash / seed2
                }
                hash = hash * seed + CGFloat(scl)
            }
        }
        return hash
    }

    var HSB: (CGFloat, CGFloat, CGFloat) {
        var hash = CGFloat(bkdrHash)
        let H = (hash % (full - 1.0)) / full
        hash /= full
        let S = saturation[Int((full * hash) % CGFloat(saturation.count))]
        hash /= CGFloat(saturation.count)
        let B = brightness[Int((full * hash) % CGFloat(brightness.count))]
        return (H, S, B)
    }

    public var color: UIColor {
        let (H, S, B) = HSB
        return UIColor(hue: H, saturation: S, brightness: B, alpha: 1.0)
    }

}
