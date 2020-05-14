//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Files
import Yams
import ColorizeSwift

// TODO: changed to SingleTon

/// Managing the settings for the tool.
class SettingsManager {
    
    struct Constants {
        static let settingFilename = "Til.yml"
        
        struct DefaultSettings {
            static let rootContentFolder = "."
            static let editor = try! Editor.fromRawValues(name: "code")
            
            static func makeDefaultSetting() -> Setting {
                return Setting(
                    root: Constants.DefaultSettings.rootContentFolder,
                    editor: Constants.DefaultSettings.editor
                )
            }
        }
        
    }
    
    // MARK: Properties
    
    // Public
    
    static let shared = SettingsManager()
    
    let rootFolder = try! Folder(path: ".")
    
    var setting: Setting!

    var rootContentFolder: Folder? {
        return try? Folder(path: setting.root)
    }
    
    // MARK: Initialization
    
    init() {
        do {
            try load()
        } catch {
            print(error)
            print("[Warning] Failed to load settings from Til.yml. Using default settings instead!".yellow())
            setting = Constants.DefaultSettings.makeDefaultSetting()
        }
    }
    
    // MARK: Private helpers
    
    private func load() throws {
        let file = try rootFolder.file(named: Constants.settingFilename)
        let settingString = String(data: try file.read(), encoding: .utf8)
        
        if let settingString = settingString {
            setting = try decodeSetting(from: settingString)
            return
        }
        
        throw Files.ReadError(path: file.path, reason: Files.ReadErrorReason.stringDecodingFailed)
    }
    
    private func decodeSetting(from string: String) throws -> Setting {
        let decoder = YAMLDecoder()
        return try decoder.decode(Setting.self, from: string)
    }
    
    private func encodeSetting(from setting: Setting) throws -> String {
        let encoder = YAMLEncoder()
        return try encoder.encode(setting)
    }
}
