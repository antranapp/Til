//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import Files
import MarkdownGenerator
import Ink
import ShellOut

/// Service class to generate a `README.md` file based on the content inside a `rootFolder`.
class ReadmeGenerationService {
    
    private struct Constants {
        static let filename = "README.md"
    }
    
    // MARK: Properties
    
    private var file: File
    private var rootFolder: Folder
    
    // MARK: Intialization
    
    init(rootFolder: Folder) throws {
        self.rootFolder = rootFolder
        
        do {
            file = try rootFolder.file(named: Constants.filename)
        } catch {
            file = try rootFolder.createFile(named: Constants.filename)
        }
    }
    
    // MARK: APIs
    
    func generate() throws -> File {
        let contentSummary = makeContentSummary()
        
        let content = header + String.newLine.x(2) +
                      contentSummary.markdown + String.newLine.x(2) +
                      tilReference + String.newLine.x(2)
        try file.write(content)
        
        return file
    }
    
    // MARK: Private helpers
        
    private func makeContentSummary() -> ContentSummary {
        let parser = MarkdownParser()
        
        let numberOfTopics = rootFolder.subfolders.count()
        let numberOfTils = rootFolder.subfolders.reduce(0) { $0 + $1.files.count()}
        
        let topics = rootFolder.subfolders.map {
            TopicSummary(
                rootFolder: rootFolder,
                name: $0.name,
                numberOfTIL: $0.files.count(),
                tils: $0.files.compactMap { file in
                    guard let entry = TilEntry.fromFile(file, parser: parser) else {
                        return nil
                    }
                    return TilSummary(tilEntry: entry)
                }
            )
        }
        
        return ContentSummary(
            numberOfTILs: numberOfTils,
            numberOfTopics: numberOfTopics,
            topics: topics
        )
    }
    
    private var header: String {
        return MarkdownHeader(title: "Today I Learned", level: .h1).markdown
    }
    
    private var tilReference: String {
        var content = "---\n" + MarkdownHeader(title: "Til Reference", level: .h1).markdown
        if let help = try? shellOut(to: "Til -h") {
            content += String.newLine.x(2) + MarkdownCodeBlock(code: help, style: .backticks(language: "bash")).markdown
        }
        return content
    }
}
