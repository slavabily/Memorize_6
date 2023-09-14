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
        let arrayOfEmojis = theme.emojis.compactMap { $0 }
        let numberPairsOfCards = theme.numberOfPairsOfCards < arrayOfEmojis.count ? theme.numberOfPairsOfCards : arrayOfEmojis.count
        self.model = MemoryGame<Character>(numberOfPairsOfCards: numberPairsOfCards) { pairIndex in
            arrayOfEmojis[pairIndex]
        }
        model.cards.shuffle()
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
        let arrayOfEmojis = selectedTheme.emojis.compactMap { $0 }
        self.model = MemoryGame<Character>(numberOfPairsOfCards: selectedTheme.numberOfPairsOfCards) { pairIndex in
            arrayOfEmojis[pairIndex]
        }
        model.cards.shuffle()
    }
}
