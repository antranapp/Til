//
//  Copyright © 2020 An Tran. All rights reserved.
//

import MarkdownGenerator

struct MarkdownStyledText: MarkdownConvertible {
    
    enum Style {
        case bold
        case italic
    }
    
    let text: String
    let style: Style
    
    init(text: String, style: Style) {
        self.text = text
        self.style = style
    }
    
    var markdown: String {
        switch style {
        case .bold:
            return "**\(text)**"
        case .italic:
            return "*\(text)*"
        }
    }
}
