//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import ArgumentParser
import ShellOut
import Files
import ColorizeSwift

/// A command to genreate a summary `README.md` based on the content in a `RootFolder`
///
/// Command: Til generate-readme [--root rootFolder]
struct GenerateReadme: ParsableCommand {
    
    // MARK: - Properties
    
    // Public
    
    static var configuration = CommandConfiguration(
        abstract: "Generate a README.md from the content."
    )
    
    @Option(name: .shortAndLong, default: nil, help: "Root folder of the content")
    private var root: String?
    
    // Private

    private var settingsManager: SettingsManager {
        let settingManager = SettingsManager()
        return settingManager
    }
    
    private var rootContentFolder: Folder {
        return try! Folder(path: rootContentPath)
    }
    
    // MARK: - APIs
    
    func run() throws {
        let service = try ReadmeGenerationService(rootFolder: rootContentFolder)
        let readmeFile = try service.generate()
        
        print("REAMDE.md generated successfully at \(readmeFile.path)!".green())
    }
    
    // MARK: - Private Helpers

    private var rootContentPath: String {
        return root ?? settingsManager.setting.root
    }
}
