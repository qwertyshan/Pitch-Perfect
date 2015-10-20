//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Shantanu Rao on 9/22/15.
//  Copyright (c) 2015 Shantanu Rao. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    @IBOutlet weak var slowAudio: UIButton!
    @IBOutlet weak var fastAudio: UIButton!
    @IBOutlet weak var stopAudio: UIButton!
    @IBOutlet weak var chipmunkAudio: UIButton!
    @IBOutlet weak var darthvaderAudio: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var audioFilePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        //if (audioFilePath != nil) {
        //    var audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
        //    audioPlayer = AVAudioPlayer(contentsOfURL: audioFileUrl, error: nil)
        //} else {
        //    print("audio file not found")
        //}
        
        stopAudio.hidden = true
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL:receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func unhighlightButtons() {
        slowAudio.highlighted = false
        fastAudio.highlighted = false
    }

    @IBAction func playSlowAudio(sender: UIButton) {
       
        unhighlightButtons()
        audioPlayer.rate = 0.5
        audioPlayer.play()
        slowAudio.highlighted = true
        if (stopAudio.hidden == true) {
            stopAudio.hidden = false
        }
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
 
        unhighlightButtons()
        audioPlayer.rate = 3.0
        audioPlayer.play()
        fastAudio.highlighted = true
        if (stopAudio.hidden == true) {
            stopAudio.hidden = false
        }
        
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
        
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1600)
        
        unhighlightButtons()
        chipmunkAudio.highlighted = true
        
        if (stopAudio.hidden == true) {
            stopAudio.hidden = false
        }
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
        
        unhighlightButtons()
        darthvaderAudio.highlighted = true
        
        if (stopAudio.hidden == true) {
            stopAudio.hidden = false
        }
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        
        if stopAudio.hidden == false {
            unhighlightButtons()
            audioPlayer.stop()
            stopAudio.hidden = true
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
