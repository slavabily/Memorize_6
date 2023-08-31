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
                            Text(theme.emojis.joined())
                        }
                    }    
                }
            }
        }
    }
}








struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        let emojiTheme = EmojiTheme()
        ThemeChooserView(emojiTheme: emojiTheme)
    }
}
