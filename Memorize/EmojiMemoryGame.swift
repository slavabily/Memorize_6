//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by slava bily on 15.08.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static func createTheme() {
        
        let name = ["cars", "faces", "trains", "animals"].randomElement() ?? "cars"
        
       theme = Theme(name: name, numberOfPairsOfCards: 100)
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        
        createTheme()
        
        return  MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            theme.emojis.shuffled()[pairIndex]
        }
        
    }
    
    static var theme = Theme(name: "cars", numberOfPairsOfCards: 100)
    
    var themeColor: Color {
        switch Self.theme.color {
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
