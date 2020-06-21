//
//  SoundManager.swift
//  MatchGame
//
//  Created by ZhangTommy on 21/6/20.
//  Copyright © 2020 Tommy Zhang. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    var audioPlayer:AVAudioPlayer?
    
    enum Sounds {
        case flip
        case match
        case wrong
        case shuffle
    }
    func playSound(_ effect:Sounds)  {
        
        var file = ""
        
        switch effect {
        case .flip:
            file = "cardflip"
            
        case .match:
            file = "dingcorrect"
            
        case .wrong:
            file = "dingwrong"
            
        case .shuffle:
            file = "shuffle"
        }
        
        if let path = Bundle.main.path(forResource: file, ofType: ".wav") {
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:  URL(fileURLWithPath: path) )
                audioPlayer?.play()
            } catch  {
                print("Couldn't create this audio player")
                return
            }
            
        } else {
            return
        }
        
        
    }
}
