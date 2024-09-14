//
//  ContentView.swift
//  Notchlogs
//
//  Created by Dmitrii Vlasov on 08/09/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query var messages: [Message]
    @Environment(\.modelContext) var modelContext

    @State var inputText = ""

    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    List {
                        ForEach(messages) { message in
                            HStack(alignment: .top) {
                                Text(message.text)
                                Spacer(minLength: 10)
                                Text(message.date.formatted(date: .omitted, time: .shortened))
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .onDelete(perform: removeMesages)
                    }
                    .onAppear {
                        if let lastItem = messages.last {
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
                        .textFieldStyle(.roundedBorder)

                    Button("Send", systemImage: "arrow.up.message") {
                        // Code to handle message saving
                        let message = Message(date: Date.now, text: inputText)
                        modelContext.insert(message)
                        inputText = ""
                    }
                }
                .padding()
            }
            .navigationTitle("Notchlogs")
            .toolbar {
                Button("Add Test Messages", systemImage: "plus", action: addTestMessages)
                Button("Delete All Messages", systemImage: "trash", action: removeAllMessages)
            }
        }
    }

    func removeMesages(at offsets: IndexSet) {
        // remove message from SwiftData
    }

    func addTestMessages() {
        for i in 0...10 {
            let message = Message(date: Date.now.addingTimeInterval(TimeInterval(i * 100)), text: "message \(i)")
            modelContext.insert(message)
        }
    }

    func removeAllMessages() {
        for message in messages {
            modelContext.delete(message)
        }
    }
}

#Preview {
    ContentView()
}
