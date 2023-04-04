import SwiftUI

struct WelcomeView: View {
    @Binding var hasOpenedApp: Bool
    var body: some View {
        ZStack {
            Image("background-welcome")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            Color.black.opacity(0.25).edgesIgnoringSafeArea(.all)

            VStack {
                Spacer(minLength: 100)

                VStack {
                    Text("Memory Lane")
                        .font(.system(size: 42, weight: .bold))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer(minLength: 0)

                    VStack(spacing: 20) {
                        Button(action: {
                            self.hasOpenedApp = true
                        }) {
                            Text("Get Started")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 35)
                                .padding(.vertical, 14)
                                .background(Color(red: 127/255, green: 191/255, blue: 123/255))
                                .cornerRadius(10)
                        }


                        Button(action: {
                            print("How does it work tapped")
                        }) {
                            Text("How does it work?")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding()
                        }
                    }
                    .padding(.horizontal, 40)

                    Spacer()
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(hasOpenedApp: .constant(false))
    }
}
