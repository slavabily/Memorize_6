//
//  EmojiTheme.swift
//  Memorize
//
//  Created by slava bily on 23.08.2023.
//

import SwiftUI

class EmojiTheme {
    
    let name: String
    var themes = [Theme]()
    
    init(named name: String) {
        self.name = name
        
        if themes.isEmpty {
            insertTheme(named: name)
        }
    }
    
    func insertTheme(named name: String, at index: Int = 0) {
        let theme = Theme(name: name, numberOfPairsOfCards: 10)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
    
    
}
