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
    @State private var isTitleEmptyError = false
    @State private var isDescriptionEmptyError = false
    
    var isValid: Bool {
        return !newNoteTitle.isEmpty && !newNoteDescription.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading) {
                Text("New Note")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 16)
                
                VStack(alignment: .leading) {
                    Text("Title")
                        .font(.headline)
                        .padding(.bottom, 4)
                    TextField("", text: $newNoteTitle)
                        .padding()
                        .border(Color("PrimaryBorderColor"), width: 1)
                        .cornerRadius(3)
                    .onChange(of: newNoteTitle) { newValue in
                        isTitleEmptyError = newValue.isEmpty
                    }
                    if isTitleEmptyError {
                        Text("come on, think of something")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 8)
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.headline)
                        .padding(.bottom, 4)
                    TextEditor(text: $newNoteDescription)
                        .frame(minHeight: 100)
                        .border(Color("PrimaryBorderColor"), width: 1)
                        .cornerRadius(3)
                        .onChange(of: newNoteDescription) { newValue in
                            isDescriptionEmptyError = newValue.isEmpty
                        }
                    if isDescriptionEmptyError {
                        Text("um...yea, you have to write something")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 16)
                
                HStack {
                    Button(action: addNote) {
                        Text("Add")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(10)
                    .disabled(!isValid)
                    
                    Button(action: cancel) {
                        Text("Cancel")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .background(Color("SecondaryBackgroundColor"))
                    .cornerRadius(10)

                }
                Spacer()
            }
            .padding()
    }
    
    func addNote() {
        let createdDate = Date()
        noteStore.addNote(title: newNoteTitle, description: newNoteDescription, createdDate: createdDate)
        newNoteTitle = ""
        newNoteDescription = ""
        isPresented = false
    }
    
    func cancel() {
        isPresented = false
    }
}
