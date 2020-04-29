//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Files
import Yams

/// Managing the settings for the tool.
struct SettingsManager {
    
    struct Constants {
        static let settingFilename = "Til.yml"
        
        struct DefaultSettings {
            static let editor = "code"
        }
        
    }
    
    // MARK: Properties
    
    public var setting: Setting!
    
    // Private

    private var rootFolder: Folder
    
    // MARK: Initialization
    
    init(rootFolder: Folder) throws {
        self.rootFolder = rootFolder
        try load()
    }
    
    // MARK: Private helpers
    
    private mutating func load() throws {
        let file = try rootFolder.file(named: Constants.settingFilename)
        let settingString = String(data: try file.read(), encoding: .utf8)
        
        if let settingString = settingString {
            setting = try decodeSetting(from: settingString)
        } else {
            setting = makeDefaultSetting()
        }
    }
    
    private func decodeSetting(from string: String) throws -> Setting {
        let decoder = YAMLDecoder()
        return try decoder.decode(from: string)
    }
    
    private func makeDefaultSetting() -> Setting {
        return Setting(editor: Constants.DefaultSettings.editor)
    }
}
