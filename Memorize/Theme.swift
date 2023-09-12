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
    var numberOfPairsOfCards: Int
    var color: ThemeColor
    var id: Int
    
    init(name: String, emojis: String, color: ThemeColor, id: Int) {
        self.name = name
        self.emojis = emojis
        self.id = id
        self.color = color
        self.numberOfPairsOfCards = emojis.count > 10 ? 10 : emojis.count
    }
    
    enum ThemeColor {
        case red
        case green
        case blue
        case yellow
    }
}
