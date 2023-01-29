//
//  NoteEditorView.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/28/23.
//

import SwiftUI

struct NoteEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var text: String
    
    let onSave: (String) -> Void
    
    init(text: Binding<String>, onSave: @escaping (String) -> Void) {
        self.onSave = onSave
        _text = text
    }
    
    func onDismiss() {
        onSave(text)
        dismiss()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $text)
                    .padding()
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        onDismiss()
                    }) {
                        Text("Done")
                    }
                }
            }
        }
    }
}

struct NoteEditorView_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditorView(text: .constant("Sample note"),
                       onSave: { _ in })
    }
}
