import SwiftUI


struct StartButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0))
            .foregroundColor(.white)
            .buttonStyle(StartButton())
            .clipShape(Capsule())
    }
}

struct StartButton2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color(red: 0, green: 0, blue: 0))
            .foregroundColor(.white)
            .buttonStyle(StartButton())
    }
}


struct LaunchScreenView: View {
    
    @State private var fadeInOut = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("LA")
                    .resizable()
                    .colorMultiply(.gray)
                    .scaledToFill()
                    .ignoresSafeArea()
                NavigationLink(destination: StartView()) {
                    Text("가보자고!")
                        .onAppear() {
                            withAnimation(Animation.easeInOut(duration: 1)
                                .repeatForever(autoreverses: true)) {
                                    fadeInOut.toggle()
                                }
                        }.opacity(fadeInOut ? 0 : 1)
                }
                .buttonStyle(StartButton())
            }
        }
    }
}




struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

