import SwiftUI

struct ContentView: View {
    @AppStorage("hasOpenedApp") var hasOpenedApp: Bool = false
    @StateObject var memories = Memories()
    @State private var navigationIndex: Int = 0

    var body: some View {
        if !hasOpenedApp {
            WelcomeView(hasOpenedApp: $hasOpenedApp)
        } else {
            ZStack {
                TabView(selection: $navigationIndex) {
                    let memoryForToday = memories.memories.first(where: { Calendar.current.isDateInToday($0.date) })
                    HomeView(memoryForToday: memoryForToday, navigationIndex: $navigationIndex)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .tag(0)
                    

                    MakeMemoryView(memoryForToday: memoryForToday)
                        .tabItem {
                             VStack {
                                 Image(systemName: "camera")
                                     .resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: 60, height: 60)
                                 Text("Make Memory")
                             }
                         }
                         .tag(1)
                        MemoriesView()
                            .tabItem {
                                Image(systemName: "list.bullet")
                                Text("Memories")
                            }
                            .tag(2)
                }
                .accentColor(.white)
                .environmentObject(memories)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
