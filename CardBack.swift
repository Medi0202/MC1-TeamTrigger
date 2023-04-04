//
//  CardBack.swift
//  SwipeTheCard
//
//  Created by Gucci on 2023/03/29.
//

import SwiftUI


struct CardBack : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
            
            ZStack {
                Image("card_back")
                    .resizable()
                    .frame(width: width, height: height)
                    .cornerRadius(20)
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardBack_Previews: PreviewProvider {
    @State static var degree: Double = 0
    static var previews: some View {
        CardBack(width: 300, height: 400, degree: $degree)
    }
}
