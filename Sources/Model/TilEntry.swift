//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation
import Files
import Ink

/// A model describing a Today-I-Learned entry.
struct TilEntry {
    
    /// A model describing the meta data of an TIL entry.
    struct MetaData {
        let title: String
        let createdAt: Date?
    }
    
    let file: File
    let meta: TilEntry.MetaData
    
    /// Extract the meta data from header of the file.
    static func fromFile(_ file: File, parser: MarkdownParser) -> TilEntry? {
        
        guard let content = try? file.readAsString() else {
            return nil
        }
        
        let result = parser.parse(content)
        
        guard let title = result.metadata["title"],
            let createdAt = result.metadata["createdAt"] else {
            return nil
        }
        return TilEntry(
            file: file,
            meta: MetaData(
                title: title,
                createdAt: Date.fromISO8601DateString(createdAt)
            )
        )
    }
}
