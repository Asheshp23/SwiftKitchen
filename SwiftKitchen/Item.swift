//
//  Item.swift
//  SwiftKitchen
//
//  Created by Ashesh Patel on 2024-11-05.
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
