//
//  HomeView.swift
//  Memory Lane
//
//  Created by Niklas Fischer on 4/4/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var memories: Memories
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 43/255, green: 75/255, blue: 38/255), Color(red: 107/255, green: 151/255, blue: 103/255)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Memory Lane").font(.largeTitle).fontWeight(.bold).padding(.top, 10).padding(.horizontal)
                    Spacer()
                }
                Text("Date")
                Text("Number of memories saved: \(memories.memories.count)")
                
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Memories(dummyMemories: Memories.createDummyData()))
    }
}
