//
//  SoundEffectView.swift
//  SwipeTheCard
//
//  Created by Gucci on 2023/03/29.
//

import SwiftUI
import AVKit

final class SoundSetting: ObservableObject {

    static let instance = SoundSetting()
    var player: AVAudioPlayer?

    enum SoundOption: String {
        case flipcard = "flipcard"
        case movecard = "movecard"
        case wave = "wave"
        case airplane = "airplane"
    }

    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("재생하는데 오류가 발생했습니다. \(error.localizedDescription)")
        }
    }
}
