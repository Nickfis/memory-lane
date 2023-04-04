//
//  MemoriesView.swift
//  Memory Lane
//
//  Created by Niklas Fischer on 4/4/23.
//

import SwiftUI
struct MemoriesView: View {
    @EnvironmentObject var memories: Memories
    
    var body: some View {
        ZStack {
            let backgroundColor = LinearGradient(gradient: Gradient(colors: [Color(red: 43/255, green: 75/255, blue: 38/255), Color(red: 107/255, green: 151/255, blue: 103/255)]), startPoint: .top, endPoint: .bottom)
            
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Past Memories").font(.largeTitle).fontWeight(.bold).padding(.top, 10).padding(.horizontal)
                    Spacer()
                }
                
                NavigationView {
                    ScrollView {
                        LazyVStack {
                            ForEach(memories.memories) { memory in
                                NavigationLink(destination: DetailedMemoryView(memory: memory)) {
                                    MemoryTile(memory: memory)
                                        .padding(.bottom)
                                }
                            }
                        }
                        .padding(.top)
                    }
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 53/255, green: 87/255, blue: 48/255), Color(red: 97/255, green: 141/255, blue: 92/255)]), startPoint: .top, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.bottom)
                }
                
                Spacer()
            }.foregroundColor(.white)
        }
    }
}
struct MemoriesView_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesView().environmentObject(Memories(dummyMemories: Memories.createDummyData()))
    }
}
