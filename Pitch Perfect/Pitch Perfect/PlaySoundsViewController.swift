//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by user27739 on 3/20/15.
//  Copyright (c) 2015 BiLore. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {

    var audioPlayer : AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
   
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate=true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        
                                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlowAudio(sender: AnyObject) {
            stopAll()
            audioPlayer.rate = 0.5
            audioPlayer.play()
        
            println(" playing slow audio ...")
    }
   @IBAction func playFastAudio(sender: AnyObject) {
 

            stopAll()
            audioPlayer.rate = 2.0
            audioPlayer.play()
            println(" playing fast audio ...")
        
    }
    
    
    @IBAction func stopPlaying(sender: AnyObject) {
        stopAll()
        println(" stop all ...")
    }
    
    func stopAll(){
        
        audioPlayer.currentTime = 0
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
    }

    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
       
        stopAll()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playDarthvaderAudio(sender: AnyObject) {
        
        playAudioWithVariablePitch(-1000)
        
    }
    
}
