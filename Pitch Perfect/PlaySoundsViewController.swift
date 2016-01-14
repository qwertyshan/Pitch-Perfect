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
    
    func unhighlightButtons() {
        slowAudio.highlighted = false
        fastAudio.highlighted = false
        chipmunkAudio.highlighted = false
        darthvaderAudio.highlighted = false
    }
    
    func resetState() {
        unhighlightButtons()
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        if (stopAudio.hidden == true) {
            stopAudio.hidden = false
        }
    }
    
    func playAudioWithVariableRate(sender: UIButton, rate: Float) {
        resetState()
        audioPlayer.rate = rate
        audioPlayer.play()
        sender.highlighted = true
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithVariableRate(sender, rate: 0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithVariableRate(sender, rate: 2.0)
    }
    
    func playAudioWithVariablePitch(sender: UIButton, pitch: Float){
        resetState()
        
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
        sender.highlighted = true
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(sender, pitch: 1600)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(sender, pitch: -1000)
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        if stopAudio.hidden == false {
            resetState()
            stopAudio.hidden = true
        }
    }

    

}
