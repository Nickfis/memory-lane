//
//  DetailedMemory.swift
//  Memory Lane
//
//  Created by Niklas Fischer on 4/4/23.
//

import SwiftUI

struct DetailedMemoryView: View {
    let memory: Memory

    var body: some View {
        VStack(alignment: .leading) {
            Text(memory.date, style: .date)
                .font(.title2)
                .padding(.top)

            if let imageData = Data(base64Encoded: memory.imageBase64),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Text("Mood: \(Int(memory.mood))")
                .font(.title3)
                .padding(.top)

            Text(memory.journalEntry)
                .padding(.top)
            
            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 53/255, green: 87/255, blue: 48/255), Color(red: 97/255, green: 141/255, blue: 92/255)]), startPoint: .top, endPoint: .bottom))
    }
}
