//
//  Theme.swift
//  Memorize
//
//  Created by slava bily on 24.08.2022.
//

import Foundation

struct Theme {
    let name: String
    let emojis: [String]
    var numberOfPairsOfCards: Int
    let color: ThemeColor
    
    init(name: String, numberOfPairsOfCards: Int) {
        self.name = name
        self.numberOfPairsOfCards = numberOfPairsOfCards
        
        func npc(emojisCount: Int) {
            if numberOfPairsOfCards > emojisCount {
                self.numberOfPairsOfCards = emojisCount
            }
        }
        
        switch name {
        case "cars":
            color = .red
            emojis = Emojis.cars.shuffled()
            npc(emojisCount: emojis.count)
        case "faces":
            color = .blue
            emojis = Emojis.faces.shuffled()
            npc(emojisCount: emojis.count)
        case "trains":
            color = .green
            emojis = Emojis.trains.shuffled()
            npc(emojisCount: emojis.count)
        case "animals":
            color = .yellow
            emojis = Emojis.animals.shuffled()
            npc(emojisCount: emojis.count)
        default:
            color = .red
            emojis = Emojis.cars.shuffled()
            npc(emojisCount: emojis.count)
        } 
    }
    
    struct Emojis {
        static let faces = ["😀","🥲","😍","😝","🤩","🙁","😭","🥶","☺️","😘","🤨","😞","😩","😳","🤗"]
        static let cars = ["🚗", "🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🦯","🦽","🦼","🛴","🚲","🛵","🏍","🛺","🚨","🚔","🚍","🚘","🚖","🚡","🚠","🚟","🚃","🚋"]
        static let trains = ["🚡","🚠","🚟","🚃","🚋","🚞","🚝","🚄","🚅","🚈","🚂","🚆","🚇","🚊","🚉"]
        static let animals = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐽","🐸"]
    }
    
    enum ThemeColor {
        case red
        case green
        case blue
        case yellow
    }
}
