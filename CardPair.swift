import SwiftUI

struct CardPair: View {
    //MARK: Variables
    let index: Int
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isSwipping = false
    @State var isLeftSwipe = true
    @State private var offset = CGSize.zero
    @State private var innerState: String = ""
    @Binding var isFlipped: Bool
    @Binding var isSwiped: Bool
    let cardFrontScript: CardFrontScript
    
    let width : CGFloat = 340
    let height : CGFloat = 440
    let durationAndDelay : CGFloat = 0.1
     
    //MARK: View Body
    var body: some View {
        let topOffset: CGFloat = Double((index <= 2 ? index : 2) * 15)
        
        return ZStack {
            CardFront(width: width, height: height,
                      cardFrontScript: cardFrontScript,
                      degree: $frontDegree,
                      innerState: $innerState,
                      isSwipping: $isSwipping,
                      isLeftSwipe: $isLeftSwipe)
            CardBack(width: width, height: height, degree: $backDegree)
        }
        .offset(x: offset.width * 1, y: -topOffset)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if isFlipped {
                        offset = gesture.translation
                        withAnimation {
                            changeTextWhileSwipping(width: offset.width)
                        }
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                        changeTextWhileSwipping(width: offset.width)
                    }
                }
        )
        .onTapGesture {
            guard !isFlipped else { return }
            flipCard()
        }
    }
    
    ///뒷면일 때 플립
    // MARK: - 뒤집기 기능
    func flipCard () {
        isFlipped.toggle()
        guard isFlipped else { return }
        SoundSetting.instance.playSound(sound: .flipcard)
        withAnimation(.linear(duration: durationAndDelay)) {
            backDegree = 90
        }
        withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
            frontDegree = 0
        }
    }
    
    /// 앞면일 때만 가능
    // MARK: - 스와이프 기능
    func swipeCard(width: CGFloat) {
        SoundSetting.instance.playSound(sound: .movecard)
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            isSwiped = true
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            isSwiped = true
        default:
            offset = .zero
        }
    }
    
    // MARK: - text 바꾸기 Yes Or No 로
    func changeTextWhileSwipping(width: CGFloat) {
        isSwipping = true
        
        switch width {
        case -500...(-10):
            innerState = cardFrontScript.leftSwipeMessage
            isLeftSwipe = true
        case 10...500:
            innerState = cardFrontScript.rightSwipeMessage
            isLeftSwipe = false
        default:
            innerState = ""
            isSwipping = false
        }
    }
    
}
