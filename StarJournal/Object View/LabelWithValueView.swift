//
//  LabelWithValueView.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/28/23.
//

import SwiftUI

struct LabelWithValueView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

struct LabelWithValueView_Previews: PreviewProvider {
    static var previews: some View {
        LabelWithValueView(
            label: "Object ID", value: "NGC2264"
        )
    }
}
