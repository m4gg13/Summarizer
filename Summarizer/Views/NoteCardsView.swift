//
//  NoteCardsView.swift
//  Summarizer
//
//  Created by Maggie Zirnhelt on 5/21/24.
//

import SwiftUI

struct NoteCardsView: View {
    let notes: [Note]

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                List(notes, id: \Note.timestamp) { note in
                    NavigationLink(destination: NoteCardView(note: note)) {
                        Text("\(note.timestamp)")
                    }
                    .listRowBackground(Color.random)
                    .padding()
                    .frame(width: geometry.size.width)
                    .border(.black)

                }
                .navigationTitle("Notes")
            }
        }
    }
}
