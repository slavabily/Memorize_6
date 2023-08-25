//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by slava bily on 15.08.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static var theme = EmojiTheme(named: "faces")
    
    static func createMemoryGame() -> MemoryGame<String> {
        
        return  MemoryGame<String>(numberOfPairsOfCards: theme.themes.first!.numberOfPairsOfCards) { pairIndex in
            theme.themes.first!.emojis.shuffled()[pairIndex]
        }
    }
    
    var themeColor: Color {
        switch Self.theme.themes.first!.color {
        case .red: return Color.red
        case .blue: return Color.blue
        case .green: return Color.green
        case .yellow: return Color.yellow
        }
    }

    @Published var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        return model.matchedCards.count - model.mismatchedCards.count
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
        print("Score: \(score)")
    }
    
    func createNewGame() {
        model = Self.createMemoryGame()
    }
}
