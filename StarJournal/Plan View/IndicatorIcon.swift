//
//  IndicatorIcon.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/30/23.
//

import SwiftUI

struct IndicatorIcon: View {
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.secondary)
            .frame(width: 25, height: 25)
    }
}

struct IndicatorIcon_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorIcon(icon: "square.and.pencil")
    }
}
