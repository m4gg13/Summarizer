//
//  ContentView.swift
//  Summarizer
//
//  Created by Maggie Zirnhelt on 5/20/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Note.timestamp) var notes: [Note]
    var newContent: String = ""

    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack {
                    Button {
                        addItem()
                    } label: {
                        Text("+")
                            .frame(width: geometry.size.width / 2.15)
                            .bold()
                    }
                    .padding()
                    .buttonStyle(.bordered)
                    Button {
                        print("this doesnt do anything yet")
                    } label: {
                        Text("Summarize")
                            .frame(width: geometry.size.width / 2.15)
                            .bold()
                    }
                    .padding()
                    .buttonStyle(.bordered)
                }
            }
            .frame(maxHeight: 30)

            List(notes, id: \Note.timestamp) { note in
                HStack {
                    Text("\(note.timestamp)")
                    Button(action: {
                        withAnimation(.easeInOut) {
                            note.isExpanded.toggle()
                        }
                    }, label: {
                        Text(">")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    })
                }
                if note.isExpanded {
                    NoteCardView(note: note)
                }
            }
        }
    }

    /*
    var body: some View {
        NavigationStack {
            List(notes) { note in
//                HStack {
//                    Text(note.contents)
//                        .bold(note.isTodaysNote)
//                    Spacer()
//                    Text(note.timestamp, format: .dateTime.month(.wide).day().year())
//                }
                NoteCardView(note: note, theme: .lavender)
                    .border(.bar)
                    .padding()
            }
            .navigationTitle("Summarizer")
            .safeAreaInset(edge: .top) {
                VStack(alignment: .center, spacing: 20) {
                    Text("New Note")
                        .font(.headline)
                }
                TextEditor(text: $newContent)
                    .foregroundColor(.white)
                    .frame(height: 100)
                Button("Save") {
                    let note = Note(timestamp: .now, contents: newContent)
                    modelContext.insert(note)

                    newContent = ""
                }
            }
            .padding()
            .background(.bar)
        }
    }
    */

    /*
     var body: some View {
     NavigationSplitView {
     List {
     ForEach(notes) { item in
     NavigationLink {
     //                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
     //                        TextEditor(text: item.$contents)
     //                                .foregroundColor(.black)
     NoteCard()
     } label: {
     Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
     }
     }
     .onDelete(perform: deleteItems)
     }
     .navigationSplitViewColumnWidth(min: 180, ideal: 200)
     .toolbar {
     ToolbarItem {
     Button(action: addItem) {
     Label("Add Item", systemImage: "plus")
     }
     }
     }
     } detail: {
     Text("Select an item")
     }
     }
     */

    private func addItem() {
        withAnimation {
            let newItem = Note(timestamp: Date(),
                               contents: newContent)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(for: Note.self, inMemory: true)
//}
