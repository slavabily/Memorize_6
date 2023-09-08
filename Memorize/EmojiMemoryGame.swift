//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by slava bily on 15.08.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published var model: MemoryGame<Character>
    
    var selectedTheme: Theme
    
    init(theme: Theme) {
        selectedTheme = theme
        self.model = MemoryGame<Character>(numberOfPairsOfCards: theme.emojis.count) { pairIndex in
            theme.emojis.shuffled()[pairIndex]
        }
    }
    
    var themeName: String {
        return selectedTheme.name
    }
    
    var themeColor: Color {
        switch selectedTheme.color {
        case .red: return Color.red
        case .blue: return Color.blue
        case .green: return Color.green
        case .yellow: return Color.yellow
        }
    }
    
    var cards: Array<MemoryGame<Character>.Card> {
        model.cards
    }
    
    var score: Int {
        return model.matchedCards.count - model.mismatchedCards.count
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<Character>.Card) {
        model.choose(card)
        print("Score: \(score)")
    }
    
    func createNewGame() {
        self.model = MemoryGame<Character>(numberOfPairsOfCards: selectedTheme.emojis.count) { pairIndex in
            selectedTheme.emojis.shuffled()[pairIndex]
        }
    }
}
