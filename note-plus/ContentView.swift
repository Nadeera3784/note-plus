import SwiftUI

struct ContentView: View {
    @State private var newNoteTitle = ""
    @State private var newNoteDescription = ""
    @ObservedObject var noteStore = NoteStore()
    @State private var isShowingDeleteConfirmation = false
    @State private var deletionIndexSet: IndexSet?
    @State private var isAddingNote = false
    @State private var selectedNote: Note? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            if noteStore.notes.isEmpty {
                Image("no-notes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .foregroundColor(.gray)
                    .alignmentGuide(.top, computeValue: { d in d[.top] })
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(noteStore.notes) { note in
                            VStack(alignment: .leading) {
                                HStack {
                                    Spacer()
                                    Button(action: { askForDeletionConfirmation(indexSet: IndexSet([noteStore.notes.firstIndex(of: note)!])) }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.black)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                Text(note.title)
                                    .font(.headline)
                                Text(note.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(5)
                                Text(note.createdDate, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.secondary.opacity(0.1))
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedNote = note
                             }
                             .sheet(item: $selectedNote) { note in
                                 NoteDetailsView(note: note)
                             }
                        }
                    }
                }
            }
            HStack{
                Button(action: { isAddingNote = true }) {
                    Image(systemName: "plus.circle.fill")
                }
                .background(Color.clear)
                .cornerRadius(10)
                .foregroundColor(.black)
                .font(.system(size: 50))
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            
        }
        .navigationTitle("Notes")
        .sheet(isPresented: $isAddingNote, content: {
                AddNoteView(isPresented: $isAddingNote, noteStore: noteStore)
        })
        .alert(isPresented: $isShowingDeleteConfirmation) {
            Alert(
                title: Text("Delete Note"),
                message: Text("Are you sure you want to delete this note?"),
                primaryButton: .destructive(Text("Delete"), action: performDeletion),
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
    }
    

    
    func askForDeletionConfirmation(indexSet: IndexSet) {
            deletionIndexSet = indexSet
            isShowingDeleteConfirmation = true
    }
        
    func performDeletion() {
        if let indexSet = deletionIndexSet {
            deleteNote(at: indexSet)
            deletionIndexSet = nil
        }
    }
    
    func addNote() {
        let createdDate = Date() // Get the current date and time
        noteStore.addNote(title: newNoteTitle, description: newNoteDescription, createdDate: createdDate)
        newNoteTitle = ""
        newNoteDescription = ""
    }
    
    func deleteNote(at offsets: IndexSet) {
        withAnimation(.easeOut(duration: 0.3)) {
            offsets.forEach { index in
                let note = noteStore.notes[index]
                noteStore.deleteNote(note)
            }
        }
    }
}
