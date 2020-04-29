//
//  Copyright © 2020 An Tran. All rights reserved.
//

import ArgumentParser

struct Til: ParsableCommand {
    
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to manage a Today-I-Learned repository",
        subcommands: [Add.self, GenerateReadme.self]
    )
}
