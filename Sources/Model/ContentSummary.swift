//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import MarkdownGenerator
import Files

/// A meta summary of a Til.
struct TilSummary {
    let tilEntry: TilEntry
}

extension TilSummary: MarkdownConvertible {
    var markdown: String {
        tilEntry.meta.title.trimmed
    }
}

/// A meta summary of a topic.
struct TopicSummary {
    let name: String
    let numberOfTIL: Int
    let tils: [TilSummary]
}

extension TopicSummary: MarkdownConvertible {
    var markdown: String {
        let listOfTils = tils.map {[
            $0.tilEntry.meta.createdAt?.asYYYYMMDD ?? "",
            MarkdownLink(
                text: $0.markdown,
                url: $0.tilEntry.file.path(
                    relativeTo: SettingsManager.shared.rootContentFolder!
                )
            ).markdown
        ]}
        
        
        let content = MarkdownTable(headers: ["Date", "Title"], data: listOfTils).markdown
        let summary = MarkdownStyledText(text: "\(name) (\(tils.count))", style: .bold).markdown
        return MarkdownCollapsibleSection(summary: summary, details: content).markdown
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
        let summary = MarkdownList(items: [numberOfTopicsString, numberOfTILsString])
        return
            summary.markdown + String.newLine.x(2) +
            topics.markdown
    }
}
