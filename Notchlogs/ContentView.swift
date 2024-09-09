//
//  ContentView.swift
//  Notchlogs
//
//  Created by Dmitrii Vlasov on 08/09/2024.
//

import SwiftUI
struct Message: Identifiable {
    var id = UUID()
    var date: Date
    var text: String
}

struct ContentView: View {
    let messages = [
        Message(date: Date.now, text: "Some message to show"),
        Message(date: Date.now, text: "Some message to show"),
        Message(date: Date.now, text: "Some message to show")
    ]

    @State var inputText = ""

    var body: some View {
        NavigationStack {
            VStack {
                List(messages) { message in
                    Text(message.text)
                }
                HStack {
                    TextField("Input", text: $inputText)
                    Button("Send", systemImage: "arrow.up.message") {
                        // Code to handle message saving
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
