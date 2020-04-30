//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import Files
import MarkdownGenerator

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
                      contentSummary.markdown
        
        try file.write(content)
        
        return file
    }
    
    // MARK: Private helpers
        
    private func makeContentSummary() -> ContentSummary {
        let numberOfTopics = rootFolder.subfolders.count()
        let numberOfTILs = rootFolder.subfolders.reduce(0) { $0 + $1.files.count()}
        
        let topics = rootFolder.subfolders.map {
            TopicSummary(
                name: $0.name,
                numberOfTIL: $0.files.count(),
                tils: $0.files.map {
                    TILSummary(
                        title: $0.name, // TODO: read title of a TIL from file
                        createdAt: $0.creationDate
                    )
                }
            )
        }
        
        return ContentSummary(
            numberOfTILs: numberOfTILs,
            numberOfTopics: numberOfTopics,
            topics: topics
        )
    }
    
    private var header: String {
        return MarkdownHeader(title: "Today I Learned", level: .h1).markdown
    }
}
