//
//  ContentView.swift
//  Memorize
//
//  Created by slava bily on 16.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    init(theme: Theme) {
        self.viewModel = EmojiMemoryGame(theme: theme)
    }
    
    var body: some View {
        VStack {
            Text("\(viewModel.themeName)")
                .font(.largeTitle)
                .fontWeight(.bold)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(
                viewModel.themeColor
            )
            .padding(.horizontal)
            Text("Score: \(viewModel.score)")
            Button("New Game") {
                viewModel.createNewGame()
            }
            .font(.largeTitle)
             
        }
        
    }
}

struct CardView: View {
    let card: MemoryGame<Character>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape
                    .fill()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(String(card.content))
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let theme = Theme(name: "Preview", emojis: "😃🥹😂🥲😇😘😍🥰", color: .green, id: 0)
        ContentView(theme: theme)
            .preferredColorScheme(.light)
    }
}
