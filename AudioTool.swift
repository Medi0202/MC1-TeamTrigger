//
//  AudioTool.swift
//  MC1_Final_TRIGGER
//
//  Created by Sunjoo IM on 2023/03/31.
//

import SwiftUI
import AVFoundation


class AudioTool {
    
    static var shared: AudioTool = AudioTool()
    
    let synthesizer = AVSpeechSynthesizer()
    
    init() {
        AVSpeechSynthesisVoice.speechVoices() // <--  fetch voice dependencies
    }
    
    func theFirst(sentence: String) {
        let utterance = AVSpeechUtterance(string: sentence)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}
