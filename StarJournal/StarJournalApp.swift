//
//  StarJournalApp.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/27/23.
//

import SwiftUI

@main
struct StarJournalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
