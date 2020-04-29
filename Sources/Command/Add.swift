//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import ArgumentParser
import ShellOut
import Files

struct Add: ParsableCommand {
    
    // MARK: - Properties
    
    static var configuration = CommandConfiguration(
        abstract: "Add a new Today-I-Learned entry using a default MarkDown editor."
    )

    @Argument(help: "The `category` of the entry, this is also the folder name.")
    private var category: String
    
    @Argument(help: "The `title` of the entry, this is also the filename of the MarkDown file.")
    private var title: String
    
    @Option(name: .shortAndLong, default: "code", help: "Optional command to launch a specific editor for MarkDown editing.")
    private var editor: String
    
    var rootFolder: Folder {
        return try! Folder(path: ".")
    }
    
    // MARK: - APIs
    
    func run() throws {
        let file = try createFile(in: category, with: title)
        try openEditor(file: file)
    }
    
    // MARK: - Private Helpers
    
    // TODO: Move all commands to a static extension of ShellOutCommand.
    
    /// Create a file with `title` as file name in folder `category`.
    private func createFile(in category: String, with title: String) throws -> File {
        let fileName = title.lowercased().asQualifiedMarkdownFilename
        let categoryFolder =  try createCategory(category: category.lowercased())
        if categoryFolder.containsFile(named: fileName) {
            return try categoryFolder.file(named: fileName)
        }
        return try categoryFolder.createFile(named: fileName, contents: makeHeader(title: title))
    }
    
    /// Open a file at `path`using an editor.
    private func openEditor(file: File) throws {
        //try shellOut(to: "code \(relativePath)")
    }
    
    /// Create default YAML header for the markdown file.
    private func makeHeader(title: String) -> Data? {
        return """
        ---
        createdAt: \(Date().asISO8601DateString)
        ---
        
        # \(title)
        """.asData
    }
    
    private func createCategory(category: String) throws -> Folder {
        guard !rootFolder.containsSubfolder(named: category) else {
            return try rootFolder.subfolder(named: category)
        }

        return try rootFolder.createSubfolder(named: category)
    }
}
