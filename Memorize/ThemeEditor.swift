//
//  ThemeEditor.swift
//  Memorize
//
//  Created by slava bily on 04.09.2023.
//

import SwiftUI

struct ThemeEditor: View {
    
    @Binding var theme: Theme
    
    var body: some View {
        Form {
            Text("Hello, World!")
        }
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(Theme(name: "Preview", emojis: "", color: .blue, id: 0)))
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/))
    }
}
