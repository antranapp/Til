//
//  Copyright © 2020 An Tran. All rights reserved.
//

import ShellOut

/// Shortcut to call all built-in Til commands from Til.
extension ShellOutCommand {
    
    static func tilAdd(topic: String, title: String) -> ShellOutCommand {
        let command = "Til add \(topic) \(title)"
        return ShellOutCommand(string: command)
    }
    
    static func tilGenerateReadme() -> ShellOutCommand {
        let command = "Til generate-readme"
        return ShellOutCommand(string: command)
    }
    
    static func tilDeploy() -> ShellOutCommand {
        let command = "Til deploy"
        return ShellOutCommand(string: command)
    }
}
