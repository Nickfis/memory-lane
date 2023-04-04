//
//  MemoryData.swift
//  Memory Lane
//
//  Created by Niklas Fischer on 4/4/23.
//

import Foundation
import UIKit

class Memory: Identifiable, Codable {
    var id = UUID()
    var date: Date
    let mood: Double
    let journalEntry: String
    var imageBase64: String

    init(date: Date, mood: Double, journalEntry: String, image: UIImage) {
        self.date = date
        self.mood = mood
        self.journalEntry = journalEntry
        self.imageBase64 = image.jpegData(compressionQuality: 1.0)?.base64EncodedString() ?? ""
    }
}

@MainActor class Memories: ObservableObject {
    @Published private(set) var memories: [Memory]
    let saveKey = "Memories"
    
    init(dummyMemories: [Memory]? = nil) {
        if let dummyMemories = dummyMemories {
            memories = dummyMemories
            return
        }
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Memory].self, from: data) {
                memories = decoded
                return
            }
        }
        memories = []
        }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(memories) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func add(_ memory: Memory) {
        let calendar = Calendar.current
            let components: Set<Calendar.Component> = [.year, .month, .day]

            if let index = memories.firstIndex(where: { calendar.dateComponents(components, from: $0.date) == calendar.dateComponents(components, from: memory.date) }) {
                memories[index] = memory
            } else {
                memories.append(memory)
            }
            save()
    }
    
    func memoryForToday() -> Memory? {
        let today = Calendar.current.startOfDay(for: Date())
        return memories.first(where: { Calendar.current.startOfDay(for: $0.date) == today })
        }
    
    static func createDummyData() -> [Memory] {
        let firstImage = UIImage(named: "example1") ?? UIImage()
        let secondImage = UIImage(named: "example2") ?? UIImage()
        let thirdImage = UIImage(named: "example3") ?? UIImage()

        return [
            Memory(date: Date(), mood: 5.0, journalEntry: "Today was a great day!", image: firstImage),
            Memory(date: Date().addingTimeInterval(-86400), mood: 4.5, journalEntry: "Yesterday was good too!", image: secondImage),
            Memory(date: Date().addingTimeInterval(-86400 * 2), mood: 3.0, journalEntry: "Two days ago was just okay.", image: thirdImage)
        ]
    }
    
    
}
