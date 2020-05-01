//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation

/// A model describing an `Editor` and its functionalities.
enum Editor: Decodable {

    // MARK: Properties
    
    case code(name: String, launchCommand: EditorLaunchCommand)

    enum CodingKeys: CodingKey {
        case name
        case gui
        case console
    }
    
    // MARK: Setup
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let name = try values.decode(String.self, forKey: .name)
        let guiCommand = try values.decodeIfPresent(String.self, forKey: .gui)
        let consoleCommand = try values.decodeIfPresent(String.self, forKey: .console)
        
        self = try Editor.fromRawValues(name: name, launchCommand: EditorLaunchCommand(gui: guiCommand, console: consoleCommand))
    }
    
    static func fromRawValues(name: String, launchCommand: EditorLaunchCommand? = nil) throws -> Editor {
        switch name {
            case "code":
                return .code(name: name, launchCommand: launchCommand ?? EditorLaunchCommand.defaultCodeLaunchCommand)
            default:
                throw EnumInitiazationError.invalidCase
        }
    }
    
    // MARK: APIs
    
    func launchCommandWithArguments(_ args: [String]) -> EditorLaunchCommand {
        switch self {
            case .code(_, let command):
                return addArguments(command: command, args: args)
        }
    }
    
    // MARK: Private helpers
    
    private func addArguments(command: EditorLaunchCommand, args: [String]) -> EditorLaunchCommand {
        let argsString = args.joined(separator: " ")
        return EditorLaunchCommand(
            gui: command.gui.map { $0 + " " + argsString } ,
            console: command.console.map { $0 + " " + argsString }
        )
    }
}


struct EditorLaunchCommand: Decodable {
    
    enum Mode: String {
        case gui
        case console
    }

    static let defaultCodeLaunchCommand = EditorLaunchCommand(
        gui: "/usr/bin/open -b com.microsoft.VSCode",
        console: "code"
    )
    
    let gui: String?
    let console: String?
    
    // MARK: APIs
    
    func command(for mode: Mode) -> String? {
        switch mode {
            case .gui:
                return gui
            case .console:
                return console
        }
    }
}

enum EnumInitiazationError: Error {
    case invalidCase
}
