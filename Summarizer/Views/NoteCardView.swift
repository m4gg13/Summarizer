//
//  NoteCardView.swift
//  Summarizer
//
//  Created by Maggie Zirnhelt on 5/21/24.
//

import SwiftUI

struct NoteCardView: View {
    @State private var isOn = false
//    @State private var checks: ((String) -> Bool) = {
//        checkDict[$0] ?? false
//    }
//    var checkDict: [String: Bool]
    @ObservedObject var note: Note
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Rendered Note")
                        Button(action: {
                            withAnimation(.easeInOut) {
                                note.renderedViewIsExpanded.toggle()
                            }
                        }, label: {
                            Text(">")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.vertical, 4)
                        })
                    }
                    if note.renderedViewIsExpanded {
                        let contents: LocalizedStringKey = LocalizedStringKey(note.contents)
                        let renderedLines: [RenderedLine] = note.renderMarkdownCheckboxes()
                        // TODO NEXT figure out how to track these checkboxes in an array
                        ForEach(renderedLines, id: \RenderedLine.id) { line in
                            @State var thisCheckboxIsOn = false

                            let markdownLine: LocalizedStringKey = LocalizedStringKey(line.line)
                            if line.checkbox {
                                Toggle(isOn: $thisCheckboxIsOn) {
                                    Text(markdownLine)
                                }
                            } else {
                                Text(markdownLine)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.headline)


            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Editable Note")
                        Button(action: {
                            withAnimation(.easeInOut) {
                                note.editViewIsExpanded.toggle()
                            }
                        }, label: {
                            Text(">")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.vertical, 4)
                        })
                    }
                    if note.editViewIsExpanded {
                        TextEditor(text: $note.contents)
                            .foregroundColor(.white)
                            .frame(height: 100)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.headline)
            .toggleStyle(.checkbox)
        }
    }
}

public struct CheckboxLine {
    var id = UUID()
    var line: String
}

public struct RenderedLine {
    var id = UUID()
    var line: String
    var checkbox: Bool
}
