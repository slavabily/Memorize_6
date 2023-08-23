//
//  MemoryGame.swift
//  Memorize
//
//  Created by slava bily on 14.08.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private(set) var alreadyBeenSeenCards: Array<Card>
    private(set) var mismatchedCards: Array<Card>
    private(set) var matchedCards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    matchedCards.append(cards[chosenIndex])
                    matchedCards.append(cards[potentialMatchIndex]) 
                    print("Matched cards: \(matchedCards.count)")
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                if alreadyBeenSeenCards.contains(where: {
                    $0.content == cards[chosenIndex].content
                }) {
                    mismatchedCards.append(cards[chosenIndex])
                    print("Mismatched cards: \(mismatchedCards.count)")
                }
                alreadyBeenSeenCards.append(cards[chosenIndex])
                print("Already been seen cards: \(alreadyBeenSeenCards.count)")
                
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }    
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        alreadyBeenSeenCards = Array<Card>()
        mismatchedCards = Array<Card>()
        matchedCards = Array<Card>()
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            var content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
