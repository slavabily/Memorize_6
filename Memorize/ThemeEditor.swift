//
//  ThemeEditor.swift
//  Memorize
//
//  Created by slava bily on 04.09.2023.
//

import SwiftUI

struct ThemeEditor: View {
    
    @State var theme: Theme
    
    var body: some View {
        Form {
            nameSection
            addEmojisSection
            removeEmojiSection
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
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
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    } 
}







struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: Theme(name: "Preview", emojis: "😀😃😄😁😆🥹😅😂🤣🥲☺️😊😇🙂🙃😉😌", color: .blue, id: 0))
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/))
    }
}
