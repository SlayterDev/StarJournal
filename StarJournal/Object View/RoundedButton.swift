//
//  RoundedButton.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/29/23.
//

import SwiftUI

struct RoundedButton: View {
    let icon: String
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .font(.title3)
            }
            .padding(.horizontal)
        }
        .padding()
        .padding(.vertical, -4)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .foregroundColor(.primary)
        .foregroundStyle(.primary)
        .cornerRadius(15)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(
            icon: "sparkles",
            title: "SkySafari",
            backgroundColor: .accentColor,
            action: {}
        )
    }
}
