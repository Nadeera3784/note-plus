//
//  AddNoteView.swift
//  note-plus
//
//  Created by Nadeera Sampath on 2023-07-09.
//

import SwiftUI

struct AddNoteView: View {
    @Binding var isPresented: Bool
    @ObservedObject var noteStore: NoteStore
    @State private var newNoteTitle = ""
    @State private var newNoteDescription = ""

    var isValid: Bool {
        return !newNoteTitle.isEmpty && !newNoteDescription.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Title", text: $newNoteTitle)
            TextEditor(text: $newNoteDescription)
                         .frame(minHeight: 100)
                         .border(Color.gray, width: 1)
                         .cornerRadius(5)
                         .padding(.vertical, 8)
            HStack {
                Button(action: addNote) {
                    Text("Add")
                }
                .padding()
                .frame(width: 150)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                .disabled(!isValid)
                
                Button(action: cancel) {
                    Text("Cancel")
                }
                .padding()
                .frame(width: 150)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(10)
            }
            .padding(.top, 16)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
    
    func addNote() {
        let createdDate = Date() // Get the current date and time
        noteStore.addNote(title: newNoteTitle, description: newNoteDescription, createdDate: createdDate)
        newNoteTitle = ""
        newNoteDescription = ""
        isPresented = false
    }
    
    func cancel() {
        isPresented = false
    }
}
