//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by slava bily on 31.08.2023.
//

import SwiftUI

struct ThemeChooserView: View {
    
    @StateObject var emojiTheme = EmojiTheme()
    
    @State private var themeToEdit: Theme?
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(emojiTheme.themes) { theme in
                    NavigationLink(destination: GameView(theme: theme)) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                                .font(.largeTitle)
                                .foregroundColor(nameColor(for: theme))
                            HStack {
                                Text("\(cardsQuantity(for: theme)) cards:")
                                Text(theme.emojis)
                                    .lineLimit(1)
                            }
                        }
                        .gesture(editMode == .active ? tap(for: theme) : nil)
                    }    
                }
                .onDelete { indexSet in
                    emojiTheme.themes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    emojiTheme.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationBarTitle("Theme Chooser")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    addNewThemeButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(item: $themeToEdit) { theme in
                ThemeEditor(theme: $emojiTheme.themes[theme])
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func cardsQuantity(for theme: Theme) -> Int {
        theme.numberOfPairsOfCards < theme.emojis.count ? theme.numberOfPairsOfCards * 2 : theme.emojis.count * 2
    }
    
    private func tap(for theme: Theme) -> some Gesture {
        TapGesture().onEnded {
            themeToEdit = theme
        }
    }
    
    var addNewThemeButton: some View {
        Button {
            emojiTheme.insertTheme(named: "New", emojis: "😀😁😅🥲😇😉🥰", color: .blue, at: 0)
            themeToEdit = emojiTheme.themes.first
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
