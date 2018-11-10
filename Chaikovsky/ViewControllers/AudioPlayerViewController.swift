//
//  AudioPlayerViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 10/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayerViewController: UIViewController {

    static var playingSong: String? = nil
    static var sharedPlayer: AVAudioPlayer? = nil
    var player: AVAudioPlayer?
    var timer: Timer? = nil
    var song = "p-i-chaykovskiy-neapolitanskaya-pesenka"


    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var compositionLabel: UILabel!
    @IBOutlet weak var passedTimeLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let asset = NSDataAsset(name: song)
            if let unwrappedAsset = asset {

                if let sharedPlayer = AudioPlayerViewController.sharedPlayer, song == AudioPlayerViewController.playingSong {
                    player = sharedPlayer
                } else {
                    try player = AVAudioPlayer(data: unwrappedAsset.data, fileTypeHint: "mp3")
                }

                guard let unwrappedPlayer = player else { return }

                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    if AudioPlayerViewController.playingSong != self.song || !unwrappedPlayer.isPlaying {
                        self.stop()
                    }
                    self.progressView.progress = Float(unwrappedPlayer.currentTime / unwrappedPlayer.duration)
                    self.passedTimeLabel.text = String(format: "%d:%02d", Int(unwrappedPlayer.currentTime) / 60, Int(unwrappedPlayer.currentTime) % 60)
                    let timeLeft = unwrappedPlayer.duration - unwrappedPlayer.currentTime
                    self.timeLeftLabel.text = String(format: "-%d:%02d", Int(timeLeft) / 60, Int(timeLeft) % 60)

                }
                timer?.fire()
            }

        } catch {
            print(error)
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stop()
    }
    
    @IBAction func play(_ sender: UIButton) {
        if let unwrappedPlayer = player {
            if unwrappedPlayer.isPlaying {
                stop()
                AudioPlayerViewController.playingSong = nil

            } else {
                unwrappedPlayer.play()
                AudioPlayerViewController.sharedPlayer = player
                AudioPlayerViewController.playingSong = song
                playButton.setImage(UIImage(named: "stop"), for: .normal)
            }
        }
    }

    func stop() {
        player?.stop()
        player?.currentTime = 0
        passedTimeLabel.text = ""
        playButton.setImage(UIImage(named: "play"), for: .normal)
    }

}
