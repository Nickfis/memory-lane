//
//  HomeView.swift
//  Memory Lane
//
//  Created by Niklas Fischer on 4/4/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var memories: Memories
    @Binding var navigationIndex: Int
    @State private var todayMemoryExists = false
    @State private var todaysMemory: Memory?
    
    
    init(memoryForToday: Memory? = nil, navigationIndex: Binding<Int>) {
        _todayMemoryExists = State(initialValue: memoryForToday != nil)
        _todaysMemory = State(initialValue: memoryForToday)
        _navigationIndex = navigationIndex
    }
    
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Text("Memory Lane").font(.largeTitle).fontWeight(.bold).padding(.top, 10).padding(.horizontal)
                    Spacer()
                }
                HStack {
                    Text("\(dateFormatter().string(from: Date()))")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    Spacer()
                }
                
                if todayMemoryExists {
                    MemoryTile(memory: todaysMemory!)
                    Button(action: {
                        print("Change it")
                        navigationIndex = 1
                    }) {
                        Text("Change how you feel about today")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 10)
                            .background(Color(red: 127/255, green: 191/255, blue: 123/255))
                            .cornerRadius(10)
                    }
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 250)
                        .padding()
                        .overlay(
                            VStack {
                                Text("You haven't created a memory for today yet.")
                                    .padding(.horizontal, 40)
                                    .multilineTextAlignment(.center)
                            }.foregroundColor(.white)
                        )
                    Button(action: {
                        print("Change it")
                        navigationIndex = 1
                    }) {
                        Text("Create a memory")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 10)
                            .background(Color(red: 127/255, green: 191/255, blue: 123/255))
                            .cornerRadius(10)
                    }
                }
                
                if !memories.memories.isEmpty {
                    if let randomMemory = memories.memories.randomElement() {
                        let daysAgo = numberOfDaysAgo(from: randomMemory.date)
                        
                            VStack {
                                HStack {
                                    Text("Remember?").font(.title).fontWeight(.bold)
                                    Spacer()
                                }
                                HStack {
                                    Text("This happened \(daysAgo) day\(daysAgo > 1 ? "s" : "") ago").font(.subheadline)
                                    Spacer()
                                }
                            }.padding(.horizontal)
                            .padding(.top, 30)
                        
                        // Use the random memory in MemoryTile
                        MemoryTile(memory: randomMemory).padding(.top, 12)
                    }
                }
                Spacer().frame(height:50)
            }.background(            LinearGradient(gradient: Gradient(colors: [Color(red: 43/255, green: 75/255, blue: 38/255), Color(red: 107/255, green: 151/255, blue: 103/255)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
            Spacer().frame(height: 0)
        }.foregroundColor(.white)
    }
    
    func numberOfDaysAgo(from date: Date) -> Int {
        let calendar = Calendar.current
        
        let startOfGivenDate = calendar.startOfDay(for: date)
        let formattedStartDate = dateFormatter().string(from: startOfGivenDate)
        let currentDate = Date()
        let startOfCurrentDate = calendar.startOfDay(for: currentDate)
        let formattedStartOfCurrentDate = dateFormatter().string(from: startOfCurrentDate)
        
        let components = calendar.dateComponents([.day], from: startOfGivenDate, to: startOfCurrentDate)
        print(components)
        
        return components.day ?? 0
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(memoryForToday: Memories.createDummyData()[0]).environmentObject(Memories(dummyMemories: Memories.createDummyData()))
//    }
//}
