//
//  ObjectDetailCell.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/28/23.
//

import SwiftUI

struct ObjectDetailCell: View {
    let obj: PlanObject
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionHeaderLabel(label: "Details")
            
            LabelWithValueView(label: "Object ID", value: obj.id ?? "")
            LabelWithValueView(label: "Constellation", value: obj.constellation ?? "")
            LabelWithValueView(label: "Type", value: obj.type ?? "")
            LabelWithValueView(label: "Magnitude", value: obj.magnitude.formatted())
            LabelWithValueView(label: "Coordinates", value: "RA \(obj.ra.toHms()) Dec \(obj.dec.toDms())")
        }
        .padding()
        .background(Color.primary.opacity(0.10))
        .cornerRadius(15)
    }
}
