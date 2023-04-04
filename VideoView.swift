//
//  VideoView.swift
//  SwipeTheCard
//
//  Created by Gucci on 2023/03/29.
//

import SwiftUI
import AVKit

struct VideoView: View {
    var player = AVPlayer()
    let videoURL = Bundle.main.url(forResource: "molly_hop", withExtension: "mov")!
    
    var body: some View {
        VideoPlayer(player: player) { }
            
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        .onAppear {
            let item = AVPlayerItem(url: videoURL)
            player.replaceCurrentItem(with: item)
        }
        .onTapGesture {
            player.seek(to: .zero)
            player.play()
        }
        .task {
            player.play()
        }
    }
    
}

struct VideoView_Preview: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
