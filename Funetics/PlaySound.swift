//
//  PlaySound.swift
//  Funetics
//
//  Created by Tanay Nistala on 5/3/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, audioType: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: audioType) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not play file")
        }
    }
}
