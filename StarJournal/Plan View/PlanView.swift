//
//  PlanView.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/28/23.
//

import SwiftUI

struct PlanView: View {
    @FetchRequest private var planObjects: FetchedResults<PlanObject>
    @ObservedObject var plan: ObservingPlan
    @Environment(\.managedObjectContext) var viewContext
    
    @Binding var selectedObject: PlanObject?
    
    init(plan: ObservingPlan, selectedObject: Binding<PlanObject?>) {
        self.plan = plan
        _selectedObject = selectedObject
        let fetchRequest = PlanObject.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "plan = %@", plan)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \PlanObject.constellation, ascending: true),
            NSSortDescriptor(keyPath: \PlanObject.magnitude, ascending: true)
        ]
        _planObjects = FetchRequest(fetchRequest: fetchRequest)
    }
    
    var body: some View {
        List {
            ForEach(planObjects) { obj in
                NavigationLink(
                    destination: ObjectView(obj: obj)
                ) {
                    HStack {
                        obj.iconForType()
                            .frame(width: 35)
                        VStack(alignment: .leading) {
                            Text(obj.id ?? "unknown")
                            Text(obj.constellation ?? "")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle(plan.name ?? "")
    }
}

extension PlanObject {
    func iconForType() -> Image {
        switch self.type {
        case "Open":
            fallthrough
        case "Globular":
            return Image(systemName: "aqi.medium")
        case "Dbl":
            fallthrough
        case "Triple":
            return Image(systemName: "sparkles")
        case "Galaxy":
            return Image(systemName: "hurricane")
        case "P Neb":
            return Image(systemName: "sun.max.circle")
        case "Nebula":
            return Image(systemName: "tornado")
        case "Moon":
            return Image(systemName: "moon.fill")
        case "Planet":
            fallthrough
        default:
            return Image(systemName: "network")
        }
    }
}
