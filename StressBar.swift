//
//  StressBar.swift
//  SwipeTheCard
//
//  Created by Gucci on 2023/03/28.
//

import SwiftUI


struct StressBar: View {
    
    @Binding var progress: Double
    @State var count = 0
    let stressAmount = 8.0
    
    var body: some View {
        
        if #available(iOS 16.0, *) {
//            GeometryReader { geo in
//                ZStack {
//                    VStack {
                        Gauge(value: progress, in: 0...100) { }
                            .animation(.easeIn(duration: 0.75), value: progress)
                            .tint(Gradient(colors: [.green, .yellow, .orange, .red]))
                            .padding([.leading, .trailing])
//                            .onTapGesture {
//                                addStress()
//                            }
//                        Button("reset") {
//                            resetStress()
//                        }
//                    }
                    
//                    Text(emoji())
//                        .font(.system(size: 35))
//                        .frame(width: geo.size.width / 30 * progress, height: geo.size.height / 50)
//                        .animation(.easeIn(duration: 0.75), value: progress)
//                }
//            }
        }
        else {
            // Fallback on earlier versions
        }
    }
    
    func emoji() -> String {
        var emoji = ""
        
        switch progress {
        case 25..<45:
            emoji = "🙁"
        case 45..<75:
            emoji = "😡"
        case 75..<100:
            emoji = "🥶"
        default:
            emoji = "😇"
        }
        
        return emoji
    }
    
    func addStress() {
        progress += stressAmount
        count += 1
    }
    
    func resetStress() {
        for _ in 0..<(count + 1) {
            progress -= stressAmount
        }
        count = 0
    }
}

struct StressBar_Previews: PreviewProvider {
    @State static var stressAmount = 0.1
    
    static var previews: some View {
        StressBar(progress: $stressAmount)
    }
}
