//
//  Item.swift
//  Xcode test
//
//  Created by CONNOR GABRIEL MAO on 8/8/24.
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
