//
//  ContentView.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/27/23.
//

import SwiftUI
import CoreData

struct PlanListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ObservingPlan.created, ascending: true)],
        animation: .default)
    private var plans: FetchedResults<ObservingPlan>
    
    @State var selectedPlan: ObservingPlan?
    @State var selectedObject: PlanObject?

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(plans) { plan in
                    NavigationLink(
                        destination: PlanView(
                            plan: plan,
                            selectedObject: $selectedObject
                        )
                    ) {
                        VStack(alignment: .leading) {
                            Text(plan.name!)
                            Text("\(plan.objects?.count ?? 0) Object(s)")
                                .font(.caption)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Plans")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } content: {
            Text("Select a plan")
        } detail: {
            Text("Select an object")
        }
    }

    private func addItem() {
        withAnimation {
            _ = JSONImporter.loadTestFile(context: viewContext)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { plans[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlanListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
