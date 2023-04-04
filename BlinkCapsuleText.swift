//
//  BlinkCapsuleText.swift
//  MC1_Final_TRIGGER
//
//  Created by Gucci on 2023/03/30.
//

import SwiftUI

struct BlinkCapsuleText: View {
    let text: String
    @State var fadeInOut = false
    
    var body: some View {
        Text(text)
            .padding()
            .background(Color(red: 0, green: 0, blue: 0))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: true)) {
                        fadeInOut.toggle()
                    }
            }
            .opacity(fadeInOut ? 0 : 1)
    }
}

struct BlinkCapsuleText_Previews: PreviewProvider {
    static let string = "샘플 텍스트"
    
    static var previews: some View {
        BlinkCapsuleText(text: string)
    }
}
