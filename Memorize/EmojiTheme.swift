//
//  EmojiTheme.swift
//  Memorize
//
//  Created by slava bily on 23.08.2023.
//

import SwiftUI

class EmojiTheme: ObservableObject {
    
   @Published var themes = [Theme]()
    
    init() {
        if themes.isEmpty {
            insertTheme(named: "Cars")
            insertTheme(named: "Faces")
            insertTheme(named: "Trains")
            insertTheme(named: "Animals")
        }
    }
    
    func insertTheme(named name: String, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, numberOfPairsOfCards: 10, id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
    
    func selectTheme(named name: String) -> Theme {
        let theme = themes.first(where: {$0.name == name})!
        return theme
    }
    
    
}
