//
//  SiriViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 10/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import SwiftSiriWaveformView

class SiriViewController: UIViewController {

    @IBOutlet private weak var waveformView: SwiftSiriWaveformView!
    private var timer: Timer?
    private var change: CGFloat = 0.01
    private var hue: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        waveformView.amplitude = 1.0
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(refreshAudioView(_:)), userInfo: nil, repeats: true)
    }

    @objc
    func refreshAudioView(_ : Timer) {
        if waveformView.amplitude <= waveformView.idleAmplitude || waveformView.amplitude > 1.0 {
            self.change *= -1.0
        }
        waveformView.amplitude += self.change
        waveformView.waveColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        hue += 0.001
        if hue >= 1.0 { hue = 0.0 }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
