//
//  ContentView.swift
//  Notchlogs
//
//  Created by Dmitrii Vlasov on 08/09/2024.
//

import SwiftUI

struct MessageGroup: Identifiable, Hashable {
    var id = UUID()
    var dateStart: Date {
        if let firstChildren = children?.first {
            return firstChildren.date
        } else {
            return Date.now
        }
    }
    var dateEnd: Date {
        if let lastChildren = children?.last {
            return lastChildren.date
        } else {
            return Date.now
        }
    }
    var text: String
    var children: [Message]?
}

struct Message: Identifiable, Hashable {
    var id = UUID()
    var date: Date
    var text: String
    var parent: MessageGroup?
}

struct ContentView: View {
    @State var lastMessage: Message?
    @State var combinedMessageText = ""

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
        Message(date: Date.now, text: "Some message to 4"),
        Message(date: Date.now, text: "Some message to 4"),
        Message(date: Date.now, text: "Some message to 4"),
        Message(date: Date.now.addingTimeInterval(50), text: "Some message to 7"),
        Message(date: Date.now.addingTimeInterval(100), text: "Some message to 7"),
        Message(date: Date.now.addingTimeInterval(100), text: "Some message to 7"),
        Message(date: Date.now.addingTimeInterval(200), text: "Some message to 9Some message to 9Some message to 9Some message to 9Some message to 9")
    ]

    private var groupedMessages: [[Message]] {
        var group = [Message]()
        var result = [[Message]]()
        var lastMessage: Message?

        for message in messages {
            if (message.text == lastMessage?.text) || group.isEmpty {
                group.append(message)
            } else {
                result.append(group)
                group = [message]
            }
            lastMessage = message
        }
        return result
    }

    @State var inputText = ""

    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    List {
                        ForEach(groupedMessages, id: \.self) { messages in
                            Section {
                                ForEach(messages) { message in
                                    HStack(alignment: .top) {
                                        Text(message.text)
                                            .id(message.id)
                                        Spacer(minLength: 10)
                                        Text(message.date.formatted(date: .omitted, time: .shortened))
                                            .font(.footnote)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .onDelete(perform: { indexSet in
                                    //                                messages.remove(atOffsets: indexSet)
                                })
                            }
                        }
                    }
                    .listSectionSpacing(10.0)
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
                        .textFieldStyle(.roundedBorder)

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
