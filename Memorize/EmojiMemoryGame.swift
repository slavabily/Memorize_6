//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by slava bily on 15.08.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published var model = MemoryGame<String>(numberOfPairsOfCards: 10) { pairIndex in
        Theme.Emojis.faces.shuffled()[pairIndex]
    }
    
    var theme = EmojiTheme()
    
    var selectedTheme: Theme?
    
    func createMemoryGame() -> MemoryGame<String> {
        self.selectedTheme = theme.selectTheme(named: "cars")
        
        return  MemoryGame<String>(numberOfPairsOfCards: selectedTheme!.numberOfPairsOfCards) { pairIndex in
            selectedTheme!.emojis.shuffled()[pairIndex]
        }
    }
    
    var themeName: String {
        guard selectedTheme != nil else { return "faces"}
        return selectedTheme!.name
    }
    
    var themeColor: Color {
        if selectedTheme != nil {
            switch selectedTheme!.color {
            case .red: return Color.red
            case .blue: return Color.blue
            case .green: return Color.green
            case .yellow: return Color.yellow
            }
        } else {
            return Color.yellow
        }
    }
    
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
        model = createMemoryGame()
    }
}
