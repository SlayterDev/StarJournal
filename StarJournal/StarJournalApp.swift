//
//  StarJournalApp.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/27/23.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        CatalogImporter.importCatalogs(into: PersistenceController.shared.container.viewContext)
        
        return true
    }
}

@main
struct StarJournalApp: App {
    let persistenceController = PersistenceController.shared

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            PlanListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
