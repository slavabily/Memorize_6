//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by slava bily on 31.08.2023.
//

import SwiftUI

struct ThemeChooserView: View {
    
    @StateObject var emojiTheme = EmojiTheme()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(emojiTheme.themes) { theme in
                    NavigationLink(destination: ContentView(theme: theme)) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                                .font(.largeTitle)
                                .foregroundColor(nameColor(for: theme))
                            HStack {
                                Text("\(theme.emojis.count) cards:")
                                Text(theme.emojis)
                                    .lineLimit(1)
                            }
                        }
                    }    
                }
            }
            .navigationBarTitle("Theme Chooser")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(leading: addNewThemeButton)
        }
    }
    
    var addNewThemeButton: some View {
        Button {
             // launching ThemeEditor with adding new theme mode active
        } label: {
            Image(systemName: "plus")
        }

    }
    
    private func nameColor(for theme: Theme) -> Color {
        return EmojiMemoryGame(theme: theme).themeColor
    }
}








struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        let emojiTheme = EmojiTheme()
        ThemeChooserView(emojiTheme: emojiTheme)
    }
}
