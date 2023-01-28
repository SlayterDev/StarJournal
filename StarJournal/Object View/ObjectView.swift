//
//  ObjectView.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/28/23.
//

import SwiftUI

struct ObjectView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    let obj: PlanObject
    
    var body: some View {
        VStack(alignment: .center) {
            Button(action: {
                
            }) {
                Text("View in Sky Safari")
                    .font(.title2)
                    .padding(.horizontal)
            }
            .padding()
            .background(Color.accentColor)
            .foregroundColor(Color.primary)
            .cornerRadius(15)
            
            ObjectDetailCell(obj: obj)
                .padding()
        }
    }
}
