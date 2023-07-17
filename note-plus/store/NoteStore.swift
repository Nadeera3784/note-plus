//
//  NoteStore.swift
//  note-plus
//
//  Created by Nadeera Sampath on 2023-07-16.
//

import Foundation
import SwiftUI

class NoteStore: ObservableObject {
    @Published var notes: [Note] = []
    private let noteManager = NoteManager()
    
    init() {
        notes = noteManager.loadNotes()
    }
    
    func addNote(title: String, description: String, createdDate: Date) {
        let newNote = Note(title: title, description: description, createdDate: createdDate)
        notes.append(newNote)
        noteManager.saveNotes(notes)
    }
    
    func deleteNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index)
            noteManager.saveNotes(notes)
        }
    }
}
