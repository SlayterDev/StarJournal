//
//  SketchEditorView.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/29/23.
//

import SwiftUI
import PencilKit

struct SketchEditorView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var sketchView = PKCanvasView()
    @State private var showClearWarning = false
    
    let onSave: (PKDrawing) -> Void
    
    init(initialDrawing: PKDrawing?, onSave: @escaping (PKDrawing) -> Void) {
        self.onSave = onSave
        if let drawing = initialDrawing {
            sketchView.drawing = drawing
        }
    }
    
    func clearCanvas() {
        sketchView.drawing = PKDrawing()
    }
    
    func dismissEditor() {
        onSave(sketchView.drawing)
        dismiss()
    }
    
    var body: some View {
        NavigationView {
            SketchView(canvasView: $sketchView)
                .navigationTitle("Sketch")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button {
                            showClearWarning = true
                        } label: {
                            Label("Clear", systemImage: "trash")
                        }
                    }
                    ToolbarItem {
                        Button {
                            dismissEditor()
                        } label: {
                            Text("Done")
                        }
                    }
                }
                .alert(isPresented: $showClearWarning) {
                    Alert(
                        title: Text("Clear Sketch?"),
                        primaryButton: .default(Text("No")),
                        secondaryButton: .destructive(Text("Yes")) {
                            clearCanvas()
                        })
                }
        }
    }
}

struct SketchEditorView_Previews: PreviewProvider {
    static var previews: some View {
        SketchEditorView(initialDrawing: nil, onSave: {_ in})
    }
}
