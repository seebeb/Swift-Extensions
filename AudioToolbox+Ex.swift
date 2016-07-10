//
//  AudioToolbox+Ex.swift
//  RemindersPlus
//
//  Created by Augus on 7/10/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation
import AudioToolbox
import AVFoundation
import MediaPlayer

class AudioToolBox: NSObject {
    
    static let shared = AudioToolBox()
    
    private var soundID: SystemSoundID = 0
    
    func playM4RWithName(_ name: String?, bundle: Bundle = Bundle.main) {
        play(bundle: bundle, name: name, type: "m4r")
    }
    
    func playMP3WithName(_ name: String?, bundle: Bundle = Bundle.main) {
        play(bundle: bundle, name: name, type: "mp3")
    }
    
    private func play(bundle: Bundle, name: String?, type: String?) {
        guard let filePath = bundle.pathForResource(name, ofType: type) else { return }
        
        let url = URL(fileURLWithPath: filePath)
        
        AudioServicesCreateSystemSoundID(url, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
}
