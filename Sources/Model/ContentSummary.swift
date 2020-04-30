//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import MarkdownGenerator

/// A meta summary of a TIL.
struct TILSummary {
    let title: String
    let createdAt: Date?
}

extension TILSummary: MarkdownConvertible {
    var markdown: String {
        return title + String.newLine
    }
}

/// A meta summary of a topic.
struct TopicSummary {
    let name: String
    let numberOfTIL: Int
    let tils: [TILSummary]
}

extension TopicSummary: MarkdownConvertible {
    var markdown: String {
        let listOfTILs = MarkdownList(items: tils.map { MarkdownLink(text: $0.title, url: "\(name)/\($0.title)") })
        return MarkdownCollapsibleSection(summary: name, details: listOfTILs.markdown).markdown
    }
}

/// A meta summary of all content.
struct ContentSummary {
    let numberOfTILs: Int
    let numberOfTopics: Int
    let topics: [TopicSummary]
}

extension ContentSummary: MarkdownConvertible {
    
    var markdown: String {
        let numberOfTILsString = "TILs: \(numberOfTILs)"
        let numberOfTopicsString = "Topics: \(numberOfTopics)"
        return
            numberOfTopicsString + String.newLine +
            numberOfTILsString + String.newLine +
            topics.markdown
    }
}
