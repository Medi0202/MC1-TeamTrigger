import SwiftUI

// 스토리 화면 (LA 도착, 엔딩)
struct StartView : View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: ContentView()) {
                // 1. 공항 도착 화면
                ZStack {
                    // 배경 이미지
                    Image("start")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        
                    
                    // Stress Gauge Bar & Story Text
                    VStack {
                        // Text
                        Text("LA 공항에 도착한 트리거 팀원들...")
                            .foregroundColor(.black)
                            .bold()
                            .multilineTextAlignment(.center)
                            .font(.system(size: 25))
                            .lineSpacing(6)
                            .frame(width: 330)
                            .offset(y: -200)
                    }
                }
            }
        }
        .onAppear {
            SoundSetting.instance.playSound(sound: .airplane)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .buttonStyle(StartButton2()) // 섬광 방지
    }
}


          // 엔딩 화면
struct EndView : View {
    var body: some View {
        
        ZStack(alignment: .top) {
            // 배경 이미지
            Image("end")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            
            // Stress Gauge Bar & Story Text
            VStack {
                
                // Text
                Text("\"구찌야.. 한국가서\n지코바에 떡 추가해줄게..\"\n이 한 마디가 구찌의 마음을 녹인다.")
                    .foregroundColor(.black)
                    .bold()
                    .multilineTextAlignment(.center)
                    .font(.system(size: 25))
                    .lineSpacing(6)
                    .frame(width: 330)
                    .offset(y: 150)
                Spacer()
                
                BlinkCapsuleText(text: "귀여운 몰리 보러가기")
                    .offset(y: -80)
            }
        }
    }
}
        
struct EndView_Preview: PreviewProvider {
    static var previews: some View {
        EndView()
    }
}
