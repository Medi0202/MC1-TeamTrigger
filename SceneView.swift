//
//  SceneView.swift
//  MC1_Final_TRIGGER
//
//  Created by Gucci on 2023/03/30.
//

import SwiftUI

struct SceneView: View {
    
    @State var sheetNumer = 0
    @State var isSwiped = false
    @State var topMent = ""
    @State var bottomMent = ""
    @State private var showModal = false
    @State private var isFliped = false
    @State var swipedCount = 0
    @State var progress: Double = 25.0
    @State var count = 0
    let stressAmount = 8.0
    let audioTool = AudioTool.shared
    
    var body: some View {
        let frontCards = makeFrontScripts()
        
        return ZStack {
            //MARK: 1
            VStack {
                // 카드 위 상황 text
                Text(topMent)
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .opacity(isFliped ? 1 : 0)
                
                
                ZStack {
                    ForEach(0..<frontCards.count, id: \.self) { index in
                        CardPair(index: index,
                                 isFlipped: $isFliped,
                                 isSwiped: $isSwiped,
                                 cardFrontScript: frontCards[index]
                        )
                    }
                }
                .offset(y: 60)
            }
            
            //MARK: 2
            NavigationLink(destination: VideoView()) { // 유빈 엔딩크래딧
                EndView()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }
            .opacity(swipedCount == frontCards.count ? 1 : 0)
            
            //MARK: - 스트레스바
            StressBar(progress: $progress)
                .offset(y: -300)
        }
        .onAppear {
            topMent = topDescriptions[sheetNumer]
            bottomMent = bottomAnswers[sheetNumer]
        }
        .onChange(of: isSwiped) { newValue in
            if newValue == true {
                showModal = true
                isSwiped = false
                isFliped = false
                addStress()
            }
        }
        .onChange(of: showModal) { newValue in
            if newValue == false {
                if swipedCount < 7 {
                    nextMent()
                }
                swipedCount += 1
                if swipedCount == 8 {
                    resetStress()
                }
            }
        }
        .onChange(of: isFliped) { newValue in
            if newValue == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    audioTool.theFirst(sentence: topMent)
                }
            }
        }
        .sheet(isPresented: $showModal) {
            if #available(iOS 16.0, *) {
                ModalView(words: bottomMent)
                    .presentationDetents([.fraction(0.4)])
            } else {
                ModalView(words: bottomMent)
            }
        }
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

    
    // 상황 텍스트
    let topDescriptions: [String] = [
        //#2
        """
        "입국심사는 프리패스지."
        영어 울렁증이 있는
        구찌의 차례가 되었다.
        """,
        //#3
        """
        "휴 드디어 통과!"
        입국 수속을 겨우 마치고 마침내 미국 땅을 밟는다.
        """,
        //#4
        """
        "와아 먹bread 찍자!"
        식당에 도착해 메뉴를 주문한다.
        """,
        //#5
        """
        든든하게 먹은 후
        유니버셜 스튜디오에 도착한다.
        "너무 재밌어! 여기서 하루종일 놀자!!"
        """,
        //#6
        """
        "와 대프리카 뺨치네."
        여름의 캘리포니아는 너무 덥다.
        """,
        //#7
        """
        "택시비 아까운데 걸어갈까?"
        39°C에 팀원들이 중꺾마를 시전한다.
        """,
        //#8
        """
        꼬르륵 저녁 시간
        "LA 왔는데 In-N-Out 먹어야지!"
        """,
        // #9
        """
        스트레스 MAX
        폭발 직전 구찌
        """
    ]
    // 결과 텍스트
    let bottomAnswers: [String] = [
        //#2
        """
        "What??"
        구찌는 추가검문 받아서 스트레스
        """,
        //#3
        """
        "괜찮을꺼야~ 캄다운 맨~"
        침착한 팀원들
        구찌는 답답해서 스트레스
        """,
        //#4
        """
        "와이 쏘 시리어스? 이야기하면서 기다리자."
        아무래도 좋은 팀원들
        구찌는 배고파서 스트레스
        """,
        //#5
        """
        "디질랜드 너나 가~"
        공감해주지 않는 팀원들
        구찌는 엘사를 못 봐서 스트레스
        """,
        //#6
        """
        "이게 LA지. 오히려 좋아"
        오히려 즐기는 팀원들
        구찌는 땀나서 스트레스
        """,
        //#7
        """
        "와 여기 예쁘다! 우리 릴스 찍자."
        그저 해맑은 팀원들
        구찌는 다리 아파서 스트레스
        """,
        //#8
        """
        "야무지게 먹어야지~"
        눈치 없는 팀원들
        구찌는 김치 마려워서 스트레스
        """,
        //#9
        """
        "야 너두?" "야 나두!"
        여유로워 보이던 팀원들도
        비슷한 고민 중이었고,
        구찌의 말에 공감한다.
        """
    ]
    
    private func nextMent() {
        sheetNumer += 1
        topMent = topDescriptions[sheetNumer]
        bottomMent = bottomAnswers[sheetNumer]
    }
    
    private func makeFrontScripts() -> [CardFrontScript] {
        let imagePaths: [String] = [
            "bg2",
            "bg3",
            "bg4",
            "bg5",
            "bg6",
            "bg7",
            "bg8",
            "bg9"
        ]
        let situationDescriptions: [String] = [
            //#2
            """
            "Why are you here?
            Who are you?
            ~!@##$%^&*()_+?"
            """,
            //#3
            """
            'LA 교통체증 골 때리는데?'
            예약한 식당에 늦을 것 같다.
            """,
            //#4
            """
            '왜 우리 음식만 안 나오는거야?'
            컴플레인을 걸고 싶다.
            """,
            //#5
            """
            '디즈니랜드도 가보고 싶은데..'
            """,
            //#6
            """
            '시원한 곳에서 좀 쉬고싶은데..'
            """,
            //#7
            """
            'ㅎㄷㄷㄷ 너희.. 안 힘드니?'
            """,
            //#8
            """
            '저것들 벌써 햄최몇 토론중이네.'
            """,
            //#9
            """
            '결심했어.
            용기를 내 속마음을 털어놓자!!!'
            """
        ]
        // swipe 선택지
        // 위를 left, 부정적, 소극적
        let leftMessages: [String] = [
            "음.. no?",     // #2
            "속으로만 안절부절", // #3
            "용기가 나지 않는다",  // #4
            "대세에 따른다",    // #5
            "속에서 된장찌개 끓는 중",    // #6
            "그래그래 맘대로 해라", // #7
            "구또참 (구찌 또 참음)", // #8
            "이 xxx들아"    // #9
        ]
        // 아래를 right, 긍정적, 적극적
        let rightMessages: [String] = [
            "음.. yes?",  // #2
            "이러다 늦는거 아냐?", // #3
            "누가 뭐라고 좀 해봐",   // #4
            "용기 내어 소신발언",  // #5
            "우리 쉬었다 가자",  // #6
            "다리 아픈데 차로 가자", // #7
            "또 햄버억? 한식 먹자!", // #8
            "이 xx들아"   // #9
        ]
        var scripts: [CardFrontScript] = []
        imagePaths.enumerated().forEach { (key, imagePath) in
            let description = situationDescriptions[key]
            let leftMessage = leftMessages[key]
            let rightMessage = rightMessages[key]
            
            let cardFrontScript = CardFrontScript(imagePath: imagePath, situationDescription: description, leftSwipeMessage: leftMessage, rightSwipeMessage: rightMessage)
            scripts.append(cardFrontScript)
        }
        return scripts.reversed()
    }
}


struct SceneView_Previews: PreviewProvider {
    static var previews: some View {
        SceneView()
    }
}
