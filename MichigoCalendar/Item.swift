//
//  Item.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/1/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
