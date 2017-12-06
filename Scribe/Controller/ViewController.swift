//
//  ViewController.swift
//  Scribe
//
//  Created by Mateus Marques on 06/12/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let pathUrl = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    
                    do {
                        let sound = try AVAudioPlayer(contentsOf: pathUrl)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {}
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: pathUrl)
                    
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There was an error: \(error)")
                        } else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                }
            }
        }
    }
    @IBAction func playButtonPressed(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
    
}

