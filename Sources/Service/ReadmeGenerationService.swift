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
    
    func generate() throws {
        let contentSummary = makeContentSummary()
        
        let content = header + String.newLine +
                      contentSummary.markdown
        
        try file.write(content)
    }
    
    // MARK: Private helpers
        
    private func makeContentSummary() -> ContentSummary {
        let numberOfTopics = rootFolder.subfolders.count()
        let numberOfTILs = rootFolder.subfolders.reduce(0) { $0 + $1.files.count()}
        return ContentSummary(
            numberOfTILs: numberOfTILs,
            numberOfTopics: numberOfTopics,
            topics: nil
        )
    }
    
    private var header: String {
        return MarkdownHeader(title: "Today I Learned", level: .h1).markdown
    }
}
