//
//  MemorizeApp.swift
//  Memorize
//
//  Created by slava bily on 16.07.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    let theme = Theme(name: "faces", numberOfPairsOfCards: 10, id: 0)
    
    var body: some Scene {
        WindowGroup {
            ContentView(theme: theme)
        }
    }
}
