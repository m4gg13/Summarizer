//
//  Note.swift
//  Summarizer
//
//  Created by Maggie Zirnhelt on 5/20/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Note: ObservableObject {
    var timestamp: Date
    var contents: String

    var isExpanded = true
    var renderedViewIsExpanded = true
    var editViewIsExpanded = true

    init(timestamp: Date, contents: String) {
        self.timestamp = timestamp
        self.contents = contents
    }

    var isTodaysNote: Bool {
        Calendar.current.isDateInToday(self.timestamp)
    }

    /// returns: the strings that should be attacked to the checkboxes
    func renderMarkdownCheckboxes() -> [RenderedLine] {
        let checkboxString = "- [ ]"

        if contents.contains(checkboxString) {
            let lines = contents.components(separatedBy: "\n")

            var renderedLines: [RenderedLine] = lines.compactMap { line in
                if line.contains(checkboxString) {
                    return RenderedLine(line: line.replacingOccurrences(of: checkboxString, with: ""), checkbox: true)
                } else {
                    return RenderedLine(line: line, checkbox: false)
                }
            }

//            let checkboxLines = lines.filter { line in
//                line.contains("- [ ]")
//            }

            return renderedLines
        } else {
            return []
        }
    }
}

//class NoteContents {
//    @ObservedObject var contents = ""
//}
