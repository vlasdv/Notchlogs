//
//  NotchlogsApp.swift
//  Notchlogs
//
//  Created by Dmitrii Vlasov on 08/09/2024.
//

import SwiftData
import SwiftUI

@main
struct NotchlogsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Message.self)
    }
}
