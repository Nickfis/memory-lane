//
//  MakeMemoryView.swift
//  Memory Lane
//
//  Created by Niklas Fischer on 4/4/23.
//
import SwiftUI

struct MakeMemoryView: View {
    @EnvironmentObject var memories: Memories
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var mood: Double
    @State private var journalEntry: String
    @State private var showActionSheet = false
    @State private var memoryAlreadyExisted: Bool
    var placeholderString: String = "Anything else you want to remember about today?"
    
    init(memoryForToday: Memory? = nil) {
        _selectedImage = State(initialValue: memoryForToday != nil ? UIImage(data: Data(base64Encoded: memoryForToday!.imageBase64)!) : nil)
        _mood = State(initialValue: memoryForToday?.mood ?? 5)
        _journalEntry = State(initialValue: memoryForToday?.journalEntry ?? "Anything else you want to remember about today?")
        _memoryAlreadyExisted = State(initialValue: memoryForToday != nil)
    }
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 43/255, green: 75/255, blue: 38/255), Color(red: 107/255, green: 151/255, blue: 103/255)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("\(dateFormatter().string(from: Date()))")
                    .font(.title)
                    .foregroundColor(.white)
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 250)
                        .overlay(
                            VStack {
                                Text("No image added to today's memory yet")
                                    .padding(.horizontal)
                                    .multilineTextAlignment(.center)
                                Text("Without an image we won't save the memory.")
                                    .padding(.horizontal)
                                    .padding(.top, 1)
                                    .multilineTextAlignment(.center)
                            }.foregroundColor(.white)
                            
                        )
                }
                    Button(action: {
                        showActionSheet = true
                    }) {
                        Text("Add a foto")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 35)
                            .padding(.vertical, 14)
                            .background(Color(red: 127/255, green: 191/255, blue: 123/255))
                            .cornerRadius(10)
                    }
                
                
                HStack {
                    Text("1")
                    Slider(value: $mood, in: 1...10, step: 1)
                        .onChange(of: mood, perform: { _ in
                            saveMemory()
                        })
                    Text("10")
                }
                Text(String(format: "Today I'm feeling like a %.0f", mood))
                TextEditor(text: $journalEntry)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(self.journalEntry == placeholderString ? Color(red: 210/255, green: 210/255, blue: 210/255) : .white)
                    .onTapGesture {
                        if self.journalEntry == placeholderString {
                            self.journalEntry = ""
                        }
                    }
                    .onChange(of: journalEntry, perform: {_ in saveMemory()})
            }
            .padding()
            .foregroundColor(.white)
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Select Photo"), buttons: [
                    .default(Text("Take a Photo")) {
                        self.sourceType = .camera
                        self.showImagePicker.toggle()
                    },
                    .default(Text("Choose from Library")) {
                        self.sourceType = .photoLibrary
                        self.showImagePicker.toggle()
                    },
                    .cancel()
                ])
            }
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
            })
        }
    }
    
    func saveMemory() {
        guard let image = selectedImage else {
            print("No image available, not saving.")
            return
        }
        print("Trying to save this memory now")
        let memory = Memory(date: Date(), mood: mood, journalEntry: journalEntry, image: image)
        memories.add(memory)
        print(memories)
    }

}


struct MakeMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        MakeMemoryView()
    }
}
