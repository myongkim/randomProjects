//
//  ViewController.swift
//  pitchPerfect
//
//  Created by Isaac Kim on 14/01/2020.
//  Copyright © 2020 Isaac Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func recordAudio(_ sender: UIButton) {
        print("record button was pressed")
        recordingLabel.text = "Recording in Progress"
        
        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        print("stop recording button was preseed")
        recordingLabel.text = "Record stopped"
    }
    
    
}

