//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Shantanu Rao on 9/19/15.
//  Copyright (c) 2015 Shantanu Rao. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordAudio: UIButton!
    @IBOutlet weak var stopAudio: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio?
    
    override func viewWillAppear(animated: Bool) {
        recordingInProgress.text = "tap to record"
        stopAudio.hidden = true
        recordAudio.enabled = true
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag){
            // Save the recorded audio
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            
            // Segue
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        if recordingInProgress.text == "tap to record" {
            recordingInProgress.text = "recording"
            stopAudio.hidden = false
            print("recording on")
        }
        recordAudio.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.text = "tap to record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        print("recording off")
    }
}
    


