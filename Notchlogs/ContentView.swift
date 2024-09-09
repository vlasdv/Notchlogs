//
//  ContentView.swift
//  Notchlogs
//
//  Created by Dmitrii Vlasov on 08/09/2024.
//

import SwiftUI
struct Message: Identifiable, Hashable {
    var id = UUID()
    var date: Date
    var text: String
}

struct ContentView: View {
    @State var messages = [
        Message(date: Date.now, text: "Some message to 1"),
        Message(date: Date.now, text: "Some message to 2"),
        Message(date: Date.now, text: "Some message to 3"),
        Message(date: Date.now, text: "Some message to 4"),
        Message(date: Date.now, text: "Some message to 5"),
        Message(date: Date.now, text: "Some message to 6"),
        Message(date: Date.now, text: "Some message to 7"),
        Message(date: Date.now, text: "Some message to 8"),
        Message(date: Date.now, text: "Some message to 9"),
        Message(date: Date.now, text: "Some message to 1"),
        Message(date: Date.now, text: "Some message to 2"),
        Message(date: Date.now, text: "Some message to 3"),
        Message(date: Date.now, text: "Some message to 4"),
        Message(date: Date.now, text: "Some message to 5"),
        Message(date: Date.now, text: "Some message to 6"),
        Message(date: Date.now, text: "Some message to 7"),
        Message(date: Date.now, text: "Some message to 8"),
        Message(date: Date.now, text: "Some message to 9"),
        Message(date: Date.now, text: "Some message to 1"),
        Message(date: Date.now, text: "Some message to 2"),
        Message(date: Date.now, text: "Some message to 3"),
        Message(date: Date.now, text: "Some message to 4"),
        Message(date: Date.now, text: "Some message to 5"),
        Message(date: Date.now, text: "Some message to 6"),
        Message(date: Date.now, text: "Some message to 7"),
        Message(date: Date.now, text: "Some message to 8"),
        Message(date: Date.now, text: "Some message to 9")
    ]

    @State var inputText = ""

    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    List {
                        ForEach(messages) { message in
                            Text(message.text)
                                .id(message.id)
                        }
                        .onDelete(perform: { indexSet in
                            messages.remove(atOffsets: indexSet)
                        })
                    }
                    .onAppear {
                        if let lastItem = messages.last {
                            print("last found")
                            proxy.scrollTo(lastItem.id, anchor: .trailing)
                        }
                    }
                    .onChange(of: messages) {
                        if let lastItem = messages.last {
                            print("last found")
                            withAnimation {
                                proxy.scrollTo(lastItem.id, anchor: .trailing)
                            }
                        }
                    }
                }

                HStack {
                    TextField("Input", text: $inputText)
                    Button("Send", systemImage: "arrow.up.message") {
                        // Code to handle message saving
                        let newMessage = Message(date: Date.now, text: inputText)
                        messages.append(newMessage)
                        inputText = ""
                    }
                }
                .padding()
            }
            .navigationTitle("Notchlogs")
        }
    }
}

#Preview {
    ContentView()
}
