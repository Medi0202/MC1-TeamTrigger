//
//  CardFront.swift
//  SwipeTheCard
//
//  Created by Gucci on 2023/03/29.
//

import SwiftUI


struct CardFront : View {
    let width : CGFloat
    let height : CGFloat
    let cardFrontScript: CardFrontScript
    let cornerRadius: CGFloat = 20
    @Binding var degree : Double
    @Binding var innerState: String
    @Binding var isSwipping: Bool
    @Binding var isLeftSwipe: Bool
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.white)
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
            
            Image(cardFrontScript.imagePath)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
                .clipped()
                .overlay {
                    VStack(alignment: isLeftSwipe ? .trailing : .leading) {
                        Text(innerState)
                            .padding()
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(cornerRadius)
                            .opacity(isSwipping ? 1 : 0)
                            .offset(y: 10)
                        
                        Spacer()
                        
                        // 구찌 속마음 text
                        Text(cardFrontScript.situationDescription)
                            .padding()
                            .font(.system(size: 24))
                            .lineSpacing(10)
                            .multilineTextAlignment(.center)
                            .background(.thickMaterial)
                            .opacity(isSwipping ? 0 : 1)
                            .offset(y: -50)
                    }
                }
            
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
