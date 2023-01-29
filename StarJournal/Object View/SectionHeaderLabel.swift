//
//  SectionHeaderLabel.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/28/23.
//

import SwiftUI

struct SectionHeaderLabel: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.title2)
            .bold()
            .padding(.bottom, 8)
    }
}

struct SectionHeaderLabel_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderLabel(label: "Details")
    }
}
