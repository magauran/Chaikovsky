//
//  UIDevice+Vibrate.swift
//  Chaikovsky
//
//  Created by Алексей on 11/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import AudioToolbox

extension UIDevice {

    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }

}
