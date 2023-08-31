//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by slava bily on 15.08.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published var model: MemoryGame<String> 
    
    var theme = EmojiTheme()
    
    var selectedTheme: Theme
    
    init(theme: Theme) {
        selectedTheme = theme
        self.model = MemoryGame<String>(numberOfPairsOfCards: 10) { pairIndex in
            theme.emojis.shuffled()[pairIndex]
        }
    }
    
    func createMemoryGame() -> MemoryGame<String> {
        self.selectedTheme = self.theme.selectTheme(named: "cars")
        
        return  MemoryGame<String>(numberOfPairsOfCards: selectedTheme.numberOfPairsOfCards) { pairIndex in
            selectedTheme.emojis.shuffled()[pairIndex]
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
