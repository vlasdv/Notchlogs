//
//  Message.swift
//  Notchlogs
//
//  Created by Dmitrii Vlasov on 14/09/2024.
//

import Foundation
import SwiftData

@Model
struct Message: Identifiable, Hashable {
    var id = UUID()
    var date: Date
    var text: String

    init(id: UUID = UUID(), date: Date, text: String) {
        self.id = id
        self.date = date
        self.text = text
    }
}
