//
//  SiriViewController.swift
//  Chaikovsky
//
//  Created by Алексей on 10/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import SwiftSiriWaveformView
import Speech
import AVFoundation

class SiriViewController: UIViewController {

    @IBOutlet private weak var waveformView: SwiftSiriWaveformView!
    private var timer: Timer?
    private var change: CGFloat = 0.01
    private var hue: CGFloat = 0.0

    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "ru-RU"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        waveformView.amplitude = 1.0
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(refreshAudioView(_:)), userInfo: nil, repeats: true)

        let string = "Смотрите как я могу говорить, ыыыыыыыыы "
        //speak(text: string)


        requestSpeechAuthorization()
        recognizeSpeech()
        //isRecording = true
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

    @IBAction func start(_ sender: Any) {

    }

    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }

    private func recognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            print("Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
            print("Speech recognition is not currently available. Check back at a later time.")
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {

                let bestString = result.bestTranscription.formattedString
                print(bestString)

                var lastString: String = ""
                for segment in result.bestTranscription.segments {
                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                    lastString = String(bestString[indexTo...])
                }
                self.checkForColorsSaid(resultString: lastString)
            } else if let error = error {
                print("There has been a speech recognition error.")
                print(error)
            }
        })
    }

    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            print(authStatus)
        }
    }

    func checkForColorsSaid(resultString: String) {
        switch resultString {
        case "красный":
            view.backgroundColor = UIColor.red
        case "оранжевый":
            view.backgroundColor = UIColor.orange
        case "жёлтый":
            view.backgroundColor = UIColor.yellow
        case "зелёный":
            view.backgroundColor = UIColor.green
        case "синий":
            view.backgroundColor = UIColor.blue
        case "чёрный":
            view.backgroundColor = UIColor.black
        case "белый":
            view.backgroundColor = UIColor.white
        case "серый":
            view.backgroundColor = UIColor.gray
        default: break
        }
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

extension SiriViewController: SFSpeechRecognizerDelegate {

    

}
