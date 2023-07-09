//
//  NoteDetailsView.swift
//  note-plus
//
//  Created by Nadeera Sampath on 2023-07-10.
//

import SwiftUI

struct NoteDetailsView: View {
    var note: Note
    
    var body: some View {
        VStack {
            Text(note.title)
                .font(.headline)
                .padding(10)
            Text(note.description)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(note.createdDate, style: .date)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .navigationTitle("Note Details")
    }
}
