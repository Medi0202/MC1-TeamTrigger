//
//  ModalView.swift
//  ModalView
//
//  Created by Sunjoo IM on 2023/03/29.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.presentationMode) var presentation
    
    let words: String
    var body: some View {
        Color.white
            .ignoresSafeArea()
            .overlay (
                VStack {
                    Text(words)
                        .font(.system(size: 24))
                        .multilineTextAlignment(.center)
                        .lineSpacing(10)
                })
    }
}


struct ModalView_Previews: PreviewProvider {
    static let word = "야호 구찌 바보"
    static var previews: some View {
        ModalView(words: word)
    }
}

// 뭐가 미안하냐 
