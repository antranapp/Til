//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import ArgumentParser
import ShellOut
import Files

extension Til {

    /// A command to genreate a summary `README.md` based on the content in a `RootFolder`
    ///
    /// Command: Til add <topic> <title> [--editor editorProgram] [-- root rootFolder]
    struct Add: ParsableCommand {
        
        // MARK: Properties
        
        // Public
        
        static var configuration = CommandConfiguration(
            abstract: "Add a new Today-I-Learned entry using a default MarkDown editor."
        )

        @Argument(help: "The `topic` of the entry, this is also the folder name.")
        private var topic: String
        
        @Argument(help: "The `title` of the entry, this is also the filename of the MarkDown file.")
        private var title: String
        
        @Option(name: .shortAndLong, default: nil, help: "Optional command to launch a specific editor for MarkDown editing.")
        private var editor: String?
        
        @Option(name: .shortAndLong, default: nil, help: "Root folder of the content")
        private var root: String?
        
        @Option(name: .shortAndLong, default: "console", help: "Launching the editor from a command-line tool or from a GUI app?")
        private var launchMode: String
        
        // Private
        
        private var rootContentFolder: Folder {
            return try! Folder(path: rootContentPath)
        }
        
        // MARK: APIs
        
        func run() throws {
            let file = try createFile(topic: topic, title: title, date: Date())
            try openEditor(file: file)
        }
        
        // MARK: Private Helpers
        
        /// Create a file with `title` as file name in folder `topic`.
        private func createFile(topic: String, title: String, date: Date) throws -> File {
            let filename = "\(date.asYYYYMMDD)_\(title.lowercased().asQualifiedMarkdownFilename)"
            let topicFolder =  try createTopic(topic: topic.lowercased())
            if topicFolder.containsFile(named: filename) {
                return try topicFolder.file(named: filename)
            }
            return try topicFolder.createFile(named: filename, contents: makeHeader(title: title, date: date))
        }
        
        /// Open a file at `path`using an editor.
        private func openEditor(file: File) throws {
            guard let launchMode = EditorLaunchCommand.Mode(rawValue: launchMode) else {
                throw AddCommandError.invalidLaunchMode
            }

            let launchCommand = try editorCommandWithArguments([file.path], launchMode: launchMode)
            print(launchCommand)
            try shellOut(to: "\(launchCommand) \(file.path)")
        }
        
        /// Create default YAML-formatted header for the markdown file.
        private func makeHeader(title: String, date: Date) -> Data? {
            return """
            ---
            title: \(title)
            createdAt: \(date.asISO8601DateString)
            ---
            
            # \(title)
            """.asData
        }
        
        /// Create a folder for a topic if needed.
        private func createTopic(topic: String) throws -> Folder {
            guard !rootContentFolder.containsSubfolder(named: topic) else {
                return try rootContentFolder.subfolder(named: topic)
            }

            return try rootContentFolder.createSubfolder(named: topic)
        }
        
        private var rootContentPath: String {
            return root ?? SettingsManager.shared.setting.root
        }
        
        private func editorCommandWithArguments(_ args: [String], launchMode: EditorLaunchCommand.Mode) throws -> String {
            if let editor = editor.map({ try? Editor.fromRawValues(name: $0) }) as? Editor {
                guard let command = editor.launchCommandWithArguments(args).command(for: launchMode) else {
                    throw AddCommandError.noLaunchCommand
                }
                return command
            }

            guard let command = SettingsManager.shared.setting.editor.launchCommandWithArguments(args).command(for: launchMode) else {
                throw AddCommandError.noLaunchCommand
            }

            return command
        }
    }
}

enum AddCommandError: Error {
    case noLaunchCommand
    case invalidLaunchMode
}
