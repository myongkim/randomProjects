//
//  RecordSoundsViewController.swift
//  pitchPerfect
//
//  Created by Isaac Kim on 14/01/2020.
//  Copyright © 2020 Isaac Kim. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidLoad")
        stopRecordingButton.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewwillappear")
    }

    @IBAction func recordAudio(_ sender: UIButton) {

        buttonPressConfigureUI()
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
//        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
             audioRecorder.delegate = self
             audioRecorder.isMeteringEnabled = true
             audioRecorder.prepareToRecord()
             audioRecorder.record()
    }
        
        
    
    
    @IBAction func stopRecording(_ sender: Any) {

        buttonPressConfigureUI()
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording was not succesful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let redordedAudioURL = sender as! URL
            playSoundVC.recordedAuioURL = redordedAudioURL
            
            
        }
    }
    
    func buttonPressConfigureUI() {
        if recordButton.isTouchInside == true {
             recordingLabel.text = "Recording in Progress"
             stopRecordingButton.isEnabled = true
             recordButton.isEnabled = false
        }
        else if stopRecordingButton.isTouchInside == true {
               stopRecordingButton.isEnabled = false
               recordButton.isEnabled = true
               recordingLabel.text = "Tap to Record"
        }
    }
    
}

