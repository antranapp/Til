//
//  Copyright © 2020 An Tran. All rights reserved.
//

/// A model describing the setting of the tool.
struct Setting: Decodable {
    let root: String
    let editor: Editor
}
