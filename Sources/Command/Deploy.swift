//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import ArgumentParser
import ShellOut
import Files

extension Til {
    
    /// A command to generate a summary `README.md`, commit and push everything to the remote repository.
    ///
    /// Command: Til deploy
    struct Deploy: ParsableCommand {
        
        // MARK: Properties
        
        // Public
        
        static var configuration = CommandConfiguration(
            abstract: "Deploy the content to the remote repository."
        )
        
        // MARK: APIs

        func run() throws {
            print(try shellOut(to: .gitPull()))            
            print("[Info] Pull from remote repository successfully!".green())
            
            print(try shellOut(to: .tilGenerateReadme()))
            
            print(try shellOut(to: .gitCommit(message: "Update \(Date().asYYYYMMDD)")))
            
            print(try shellOut(to: .gitPush()))
        }
    }
}


extension ShellOutCommand {
    
    /// Calling generate-readme command
    static func tilGenerateReadme() -> ShellOutCommand {
        return ShellOutCommand(string: "Til generate-readme")
    }
}
