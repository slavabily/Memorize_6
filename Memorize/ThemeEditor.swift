//
//  ThemeEditor.swift
//  Memorize
//
//  Created by slava bily on 04.09.2023.
//

import SwiftUI

struct ThemeEditor: View {
    
    @Environment(\.dismiss) var disniss
    
    @Binding var theme: Theme
    
    var body: some View {
        NavigationView {
            Form {
                nameSection
                cardsQuantitySection
                colorChoosingSection
                addEmojisSection
                removeEmojiSection
            }
            .frame(minWidth: 300, minHeight: 350)
            .interactiveDismissDisabled()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                         disniss()
                    }
                }
            }
        }  
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    @State private var numderOfCards = ""
    
    var cardsQuantitySection: some View {
        Section {
            TextField("even number", text: $numderOfCards)
                .onChange(of: numderOfCards) { noc in
                    theme.numberOfPairsOfCards = numberOfCards(inString: noc) / 2
                    print("theme.numberOfPairsOfCards: \(theme.numberOfPairsOfCards)")
                }
                .keyboardType(.numberPad)
        } header: {
            Text("Quantity of cards")
        } footer: {
            Text("Please, add some emojis before adding cards quantity")
        }
    }
    
    private func numberOfCards(inString: String) -> Int {
        let numberOfCardsInInt = Int(inString) ?? 0
        return numberOfCardsInInt < theme.emojis.count ? numberOfCardsInInt : theme.emojis.count
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                     addEmojis(emojis)
                }
        }
    }
    
   private func addEmojis(_ emojis: String) {
       withAnimation {
           theme.emojis = (emojis + theme.emojis)
               .filter({ char in
                   char.isEmoji
               })
               .removingDuplicateCharacters
       }
    }
    
    var removeEmojiSection: some View {
        Section(header: Text("Remove Emoji")) {
            let emojis = theme.emojis.removingDuplicateCharacters.map {
                String($0)
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.removeAll(where: { String($0) == emoji })
                                emojisToAdd.removeAll(where: { String($0) == emoji })
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
    
    var colors: [Theme.ThemeColor] = [.blue, .green, .red, .yellow]
    
    var colorChoosingSection: some View {
        Section {
            Picker(selection: $theme.color) {
                ForEach(colors, id: \.self) {
                    Text(String(describing: $0))
                }
            } label: {
                 
            }.pickerStyle(.segmented)
        } header: {
            Text("Choose Color")
        }
    }
}







struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(Theme(name: "Preview", emojis: "😀😃😄😁😆🥹😅😂🤣🥲☺️😊😇🙂🙃😉😌", color: .blue, id: 0)))
            .previewLayout(.sizeThatFits)
            
    }
}
