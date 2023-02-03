//
//  CatalogImporter.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/31/23.
//

import Foundation
import CoreData

struct CatalogImporter {
    static func importCatalogs(into viewContext: NSManagedObjectContext) {
        guard !UserDefaults.standard.bool(forKey: "prefilled") else { return }
        
        // TODO: Loading UI
        
        CSVParser.parse(fromUrl: Bundle.main.url(forResource: "Historic_NGCIC", withExtension: "csv")!,
                            lineParser: NGCICParser(),
                            context: viewContext)
        
        CSVParser.parse(fromUrl: Bundle.main.url(forResource: "Historic_M", withExtension: "csv")!,
                            lineParser: MessierParser(),
                            context: viewContext)
        
        CSVParser.parse(fromUrl: Bundle.main.url(forResource: "SAO", withExtension: "csv")!,
                            lineParser: SAOParser(),
                            context: viewContext)
        
        do {
            try viewContext.save()
            UserDefaults.standard.set(true, forKey: "prefilled")
        } catch {
            print(error)
        }
    }
}
