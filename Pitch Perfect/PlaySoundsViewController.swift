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
        
        stopAudio.hidden = true
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL:receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func unhighlightButtons() {
        slowAudio.highlighted = false
        fastAudio.highlighted = false
    }

    @IBAction func playSlowAudio(sender: UIButton) {
       
        unhighlightButtons()
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayer.rate = 0.5
        audioPlayer.play()
        slowAudio.highlighted = true
        if (stopAudio.hidden == true) {
            stopAudio.hidden = false
        }
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
 
        unhighlightButtons()
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
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
            audioEngine.stop()
            audioEngine.reset()
            stopAudio.hidden = true
        }
    }

    

}
