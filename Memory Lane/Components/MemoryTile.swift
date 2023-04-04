//
//  MemoryTile.swift
//  Memory Lane
//
//  Created by Niklas Fischer on 4/4/23.
//

import SwiftUI
struct MemoryTile: View {
    var memory: Memory
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let imageData = Data(base64Encoded: memory.imageBase64),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9 * 0.7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .clipped() // Add clipped modifier here
            }
        }
        .overlay( // Add this new background
            ZStack {
                Color.black.opacity(0.5)
                
                VStack {
                    Text(memory.date, style: .date).font(.title).fontWeight(.bold).padding(.bottom, 1)
                    Text("Mood: \(Int(memory.mood))").font(.headline)
                }
                .foregroundColor(.white)
            }
            .cornerRadius(10)
        )
    }
}
