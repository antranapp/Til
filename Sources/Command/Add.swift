//
//  Copyright © 2020 An Tran. All rights reserved.
//

import ArgumentParser
import ShellOut

struct Add: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Add a new Today-I-Learned entry using a default MarkDown editor."
    )
    
    @Argument(help: "The `category` of the entry, this is also the folder name.")
    private var category: String
    
    @Argument(help: "The `title` of the entry, this is also the filename of the MarkDown file.")
    private var title: String
    
    @Option(name: .shortAndLong, default: "code", help: "Optional command to launch a specific editor for MarkDown editing.")
    private var editor: String
    
    func run() throws {
        print("Hello World")
        print(try shellOut(to: "code"))
    }
}
