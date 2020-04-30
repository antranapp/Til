//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import MarkdownGenerator

extension String {
    
    /// Return a qualified filename derived from `self` for the markdown file.
    var asQualifiedMarkdownFilename: String {
        let alphaNumericsSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789")
        let validCharacterSet = alphaNumericsSet.union(CharacterSet.whitespaces)
        let alphaNumericsFileName = self.components(separatedBy: validCharacterSet.inverted).joined()
        return alphaNumericsFileName.withCondensedWhitespace.replacingOccurrences(of: " ", with: "-").appending(".md")
    }
    
    /// Remove excessive whitespaces in `self`.
    var withCondensedWhitespace: String {
        self.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
    }
    
    var asData: Data? {
        self.data(using: .utf8)
    }
    
    func x(_ times:Int) -> String {
        String(repeating: self, count: times)
    }
    
    var trimmed: String {
        self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    static var newLine: String = "\n"
}
