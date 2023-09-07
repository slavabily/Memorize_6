//
//  Theme.swift
//  Memorize
//
//  Created by slava bily on 24.08.2022.
//

import Foundation

struct Theme: Identifiable, Hashable {
    var name: String
    var emojis: String
    var numberOfPairsOfCards: Int = 10
    let color: ThemeColor
    var id: Int
    
    init(name: String, emojis: String, color: ThemeColor, id: Int) {
        self.name = name
        self.emojis = emojis
        self.id = id
        self.color = color
    }
    
    enum ThemeColor {
        case red
        case green
        case blue
        case yellow
    }
}
