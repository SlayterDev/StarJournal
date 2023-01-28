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
    
    func openInSkySafari() {
        let url = URL(string: "https://icandiapps.com/infopack/\(obj.id ?? "")")!
        UIApplication.shared.open(url)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ObjectDetailCell(obj: obj)
                .padding()
            
            Button(action: {
                openInSkySafari()
            }) {
                Text("View in Sky Safari")
                    .font(.title2)
                    .padding(.horizontal)
            }
            .padding()
            .background(Color.accentColor)
            .foregroundColor(Color.primary)
            .cornerRadius(15)
            
            Spacer()
        }
        .navigationTitle(obj.id ?? "Unknown")
    }
}
