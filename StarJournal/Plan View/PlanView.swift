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
                    Text(obj.id ?? "unknown")
                }
            }
        }
        .navigationTitle(plan.name ?? "")
    }
}
