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
        VStack(alignment: .leading) {
            Text(obj.id ?? "")
                .font(.headline)
            HStack {
                Text(obj.type ?? "")
                Text("\(obj.magnitude.formatted())")
            }
        }
    }
}
