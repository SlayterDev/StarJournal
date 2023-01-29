//
//  ObjectView.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/28/23.
//

import SwiftUI
import PencilKit

struct ObjectView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State var showingNoteEditor = false
    
    let obj: PlanObject
    @State var notes: String = ""
    
    @State var sketchDrawing: PKDrawing?
    @State var showingSketchEditor = false
    
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
    
    func openSketchView() {
        if let drawingData = obj.drawing {
            do {
                sketchDrawing = try PKDrawing(data: drawingData)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        showingSketchEditor = true
    }
    
    func saveSketch(_ sketch: PKDrawing) {
        guard !sketch.bounds.isEmpty else { return }
        
        sketchDrawing = sketch
        obj.drawing = sketch.dataRepresentation()
        obj.image = sketch.image(from: sketch.bounds, scale: UIScreen.main.scale).pngData()
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func dataToUIImage(_ imageData: Data?) -> UIImage? {
        guard let imageData = imageData else { return nil }
        
        return UIImage(data: imageData)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if let image = dataToUIImage(obj.image) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .frame(maxWidth: .infinity)
            }
            
            
            ObjectDetailCell(obj: obj)
            
            HStack {
                RoundedButton(
                    icon: "sparkles",
                    title: "SkySafari",
                    backgroundColor: .accentColor,
                    action: openInSkySafari
                )
                
                RoundedButton(
                    icon: "scribble.variable",
                    title: "Sketch",
                    backgroundColor: Color(red: 0.349, green: 0, blue: 0.702),
                    action: openSketchView
                )
            }
            
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
        .sheet(isPresented: $showingSketchEditor) {
            SketchEditorView(initialDrawing: sketchDrawing, onSave: saveSketch)
        }
    }
}
