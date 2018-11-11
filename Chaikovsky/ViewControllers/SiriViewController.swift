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
    private var isRecording = false
    private var recordedString = ""
    private var service = NetworkService()
    private let synth = AVSpeechSynthesizer()

    @IBOutlet weak var tipsStackView: UIStackView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var instructionLabel: UILabel!
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "ru-RU"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        requestSpeechAuthorization()
        questionLabel.text = ""
        answerLabel.text = ""
        setupNavigationController()
        setupWaveformView()
        scrollView.contentSize.width = view.frame.width
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        tipsStackView.isHidden = true
        if !isRecording {
            recognizeSpeech()
            instructionLabel.text = "Нажми, чтобы завершить вопрос"
        }
        isRecording.toggle()
        waveformView.isHidden.toggle()
        recordButton.isHidden.toggle()
        answerLabel.text = ""
    }

    func setSessionPlayerOn() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: .mixWithOthers)
        } catch _ {}
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {}
        do {
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {}
    }

    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
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
                self.recordedString = bestString
                self.questionLabel.text = bestString
            }
        })
    }

    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            print(authStatus)
        }
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = .linkColor
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func setupWaveformView() {
        waveformView.amplitude = 1.0
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(refreshAudioView(_:)), userInfo: nil, repeats: true)
    }

    @IBAction func stop(_ sender: Any) {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
        let finalText = recordedString
        print(finalText)
        setSessionPlayerOn()

        service.ask(question: finalText) { [weak self] (answer) in
            if let ans = answer {
                self?.speak(text: ans)
                DispatchQueue.main.async {
                    self?.answerLabel.text = ans
                }
            }
        }

        recordedString = ""
        instructionLabel.text = "Нажми, чтобы задать вопрос"
        isRecording.toggle()
        waveformView.isHidden.toggle()
        recordButton.isHidden.toggle()

        UIDevice.vibrate()
    }

}

extension SiriViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }

}
