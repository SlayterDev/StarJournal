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
    
    @Binding var sketchView: PKCanvasView
    
    @State private var showClearWarning = false
    
    let onSave: (UIImage) -> Void
    
    let templateImage = UIImage(named: "SketchTemplate")!
    
    func clearCanvas() {
        sketchView.drawing = PKDrawing()
    }
    
    func dismissEditor() {
        let sketchImage = sketchView.drawing.image(from: sketchView.bounds, scale: UIScreen.main.scale)
        
        onSave(templateImage.mergeWith(topImage: sketchImage))
        dismiss()
    }
    
    var body: some View {
        NavigationView {
            Image(uiImage: templateImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(SketchView(canvasView: $sketchView), alignment: .bottomLeading)
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
        SketchEditorView(sketchView: .constant(PKCanvasView()), onSave: {_ in})
    }
}
