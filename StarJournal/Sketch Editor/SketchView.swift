//
//  SketchView.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/29/23.
//

import SwiftUI
import PencilKit

struct SketchView {
    @Binding var canvasView: PKCanvasView
}

extension SketchView: UIViewRepresentable {
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: .gray, width: 10)
        canvasView.drawingPolicy = .anyInput
        canvasView.isOpaque = false
        canvasView.backgroundColor = .clear
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
}
