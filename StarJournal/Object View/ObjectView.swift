//
//  ObjectView.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/28/23.
//

import SwiftUI

struct ObjectView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State var showingNoteEditor = false
    
    let obj: PlanObject
    @State var notes: String = ""
    
    init(obj: PlanObject) {
        self.obj = obj
        _notes = State(initialValue: obj.notes!)
    }
    
    func openInSkySafari() {
        let url = URL(string: "https://icandiapps.com/infopack/\(obj.id ?? "")")!
        UIApplication.shared.open(url)
    }
    
    func openNotesView() {
//        loadObservation()
        
        showingNoteEditor = true
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ObjectDetailCell(obj: obj)
            
            Button(action: {
                openInSkySafari()
            }) {
                Text("View in Sky Safari")
                    .font(.title3)
                    .padding(.horizontal)
            }
            .padding()
            .padding(.vertical, -4)
            .background(Color.accentColor)
            .foregroundColor(Color.primary)
            .cornerRadius(15)
            
            Group {
                HStack {
                    SectionHeaderLabel(label: "Notes")
                    Spacer()
                    Button(action: {
                        openNotesView()
                    }) {
                        Text("Edit")
                    }
                }
                
                Group {
                    Text(notes)
                        .lineLimit(nil)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                }
                .padding()
                .background(Color.primary.opacity(0.10))
                .cornerRadius(15)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(obj.id ?? "Unknown")
        .onAppear {
//            loadObservation()
        }
        .sheet(isPresented: $showingNoteEditor) {
            NoteEditorView(
                text: $notes,
                onSave: { noteStr in
                    obj.notes = noteStr
                    do {
                        try viewContext.save()
//                        loadObservation()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            )
        }
    }
}
