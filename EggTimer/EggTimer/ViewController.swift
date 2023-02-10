//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var zero: UILabel!
    
    let eggTimes=["Soft":300,"Medium":420,"Hard":720]
    
    var totalTime=0
    var secondsPassed=0
    var timer=Timer()
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness=sender.currentTitle!
        
        totalTime=eggTimes[hardness]!
        
        progressView.progress=0
        secondsPassed=0
        titleLabel.text=hardness
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
    }
    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    @objc func updateTimer() {
        //example functionality
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            zero.text=String((Float(secondsPassed)/Float(totalTime))*100)
            progressView.progress=Float(secondsPassed)/Float(totalTime)
            
            
        }else{
            timer.invalidate()
            titleLabel.text="DONE!!"
            playSound()
        }
        
        
    }
}
