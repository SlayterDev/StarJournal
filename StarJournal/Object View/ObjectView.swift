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
    
    @State var notes: String = ""
    
    @State var sketchView = PKCanvasView()
    @State var showingSketchEditor = false
    
    let obj: PlanObject
    
    let cycleObject: (Int) -> Void
    
    init(obj: PlanObject, cycleObject: @escaping (Int) -> Void) {
        self.obj = obj
        self.cycleObject = cycleObject
        _notes = State(initialValue: obj.notes!)
    }
    
    func openInSkySafari() {
        let url = URL(string: "https://icandiapps.com/infopack/\(obj.id ?? "")")!
        UIApplication.shared.open(url)
    }
    
    func openNotesView() {
        showingNoteEditor = true
    }
    
    func openSketchView() {
        if let drawingData = obj.drawing {
            do {
                let sketchDrawing = try PKDrawing(data: drawingData)
                sketchView.drawing = sketchDrawing
            } catch {
                print(error.localizedDescription)
            }
        }
        
        showingSketchEditor = true
    }
    
    func saveSketch(flatImage: UIImage) {
        guard !sketchView.drawing.bounds.isEmpty else { return }
        
        let sketch = sketchView.drawing
        obj.drawing = sketch.dataRepresentation()
        obj.image = flatImage.pngData()
        
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
        ScrollView {
            VStack(alignment: .center) {
                if let image = dataToUIImage(obj.image) {
                    ImageFrame(image: image)
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
                            Label("Edit", systemImage: "square.and.pencil")
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
        }
        .navigationTitle(obj.id ?? "Unknown")
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    cycleObject(-1)
//                }) {
//                    Label("Previous Object", systemImage: "arrow.left")
//                }
//            }
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    cycleObject(1)
//                }) {
//                    Label("Next Object", systemImage: "arrow.right")
//                }
//            }
//        }
        .sheet(isPresented: $showingNoteEditor) {
            NoteEditorView(
                text: $notes,
                onSave: { noteStr in
                    obj.notes = noteStr
                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            )
        }
        .sheet(isPresented: $showingSketchEditor) {
            SketchEditorView(sketchView: $sketchView, onSave: saveSketch)
        }
    }
}
