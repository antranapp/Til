//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import MarkdownGenerator

struct TILSummary {
    let title: String
    let createdAt: Date
}

struct TopicSummary {
    let name: String
    let numberOfTIL: Int
    let tils: [TILSummary]?
}

/// A meta summary of all content.
struct ContentSummary {
    let numberOfTILs: Int
    let numberOfTopics: Int
    let topics: [TopicSummary]?
}

extension ContentSummary: MarkdownConvertible {
    
    var markdown: String {
        let numberOfTILsString = "TILs: \(numberOfTILs)"
        let numberOfTopicsString = "Categories: \(numberOfTopics)"
        return numberOfTILsString + String.newLine + numberOfTopicsString
    }
}
