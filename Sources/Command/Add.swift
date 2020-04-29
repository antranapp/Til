//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import ArgumentParser
import ShellOut
import Files

struct Add: ParsableCommand {
    
    // MARK: - Properties
    
    // Public
    
    static var configuration = CommandConfiguration(
        abstract: "Add a new Today-I-Learned entry using a default MarkDown editor."
    )

    @Argument(help: "The `category` of the entry, this is also the folder name.")
    private var category: String
    
    @Argument(help: "The `title` of the entry, this is also the filename of the MarkDown file.")
    private var title: String
    
    @Option(name: .shortAndLong, default: nil, help: "Optional command to launch a specific editor for MarkDown editing.")
    private var editor: String?
    
    @Option(name: .shortAndLong, default: SettingsManager.Constants.DefaultSettings.root, help: "Root folder of the content")
    private var root: String
    
    // Private

    private var settingsManager: SettingsManager {
        let settingManager = try! SettingsManager(rootFolder: self.rootFolder)
        return settingManager
    }
    
    private var rootFolder: Folder {
        return try! Folder(path: root)
    }
    
    // MARK: - APIs
    
    func run() throws {
        let file = try createFile(category: category, title: title, date: Date())
        try openEditor(file: file)
    }
    
    // MARK: - Private Helpers
    
    // TODO: Move all commands to a static extension of ShellOutCommand.
    
    /// Create a file with `title` as file name in folder `category`.
    private func createFile(category: String, title: String, date: Date) throws -> File {
        let filename = "\(date.asYYYYMMDD)_\(title.lowercased().asQualifiedMarkdownFilename)"
        let categoryFolder =  try createCategory(category: category.lowercased())
        if categoryFolder.containsFile(named: filename) {
            return try categoryFolder.file(named: filename)
        }
        return try categoryFolder.createFile(named: filename, contents: makeHeader(title: title, date: date))
    }
    
    /// Open a file at `path`using an editor.
    private func openEditor(file: File) throws {
        try shellOut(to: "\(editor ?? settingsManager.setting.editor) \(file.path)")
    }
    
    /// Create default YAML-formatted header for the markdown file.
    private func makeHeader(title: String, date: Date) -> Data? {
        return """
        ---
        createdAt: \(date.asISO8601DateString)
        ---
        
        # \(title)
        """.asData
    }
    
    /// Create a folder for a category if needed.
    private func createCategory(category: String) throws -> Folder {
        guard !rootFolder.containsSubfolder(named: category) else {
            return try rootFolder.subfolder(named: category)
        }

        return try rootFolder.createSubfolder(named: category)
    }
}
