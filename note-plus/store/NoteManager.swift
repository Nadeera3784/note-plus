//
//  NoteManager.swift
//  note-plus
//
//  Created by Nadeera Sampath on 2023-07-17.
//

import Foundation

class NoteManager {
    private let userDefaults = UserDefaults.standard
    private let notesKey = "notes"
    
    func saveNotes(_ notes: [Note]) {
        do {
            let encodedData = try JSONEncoder().encode(notes)
            userDefaults.set(encodedData, forKey: notesKey)
        } catch {
            print("Failed to encode notes: \(error)")
        }
    }
    
    func loadNotes() -> [Note] {
        guard let encodedData = userDefaults.data(forKey: notesKey) else {
            return []
        }
        
        do {
            let notes = try JSONDecoder().decode([Note].self, from: encodedData)
            return notes
        } catch {
            print("Failed to decode notes: \(error)")
            return []
        }
    }
}
