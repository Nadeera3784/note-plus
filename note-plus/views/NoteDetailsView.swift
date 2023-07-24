//
//  NoteDetailsView.swift
//  note-plus
//
//  Created by Nadeera Sampath on 2023-07-10.
//

import SwiftUI


struct NoteDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    var note: Note

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Text(note.title)
                    .font(.headline)
                    .padding(10)
                
                ScrollView {
                    VStack {
                        Text(note.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(note.createdDate, style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                }
            }
            
            HStack{
                Button(action: cancel) {
                    Text("Cancel")
                        .padding()
                        .frame(width: 200, height: 50)
                        .foregroundColor(.black)
                        .background(Color("SecondaryBackgroundColor"))
                        .cornerRadius(10)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
}

