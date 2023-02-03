//
//  JSONImporter.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/27/23.
//

import Foundation
import CoreData

struct ObjectData: Codable {
    let id: String
    let magnitude: String
    let objecttype: String
    let ra: String
    let dec: String
    let constellation: String
    let name: String
}

struct PlanData: Codable {
    let objects: [ObjectData]
}

struct JSONImporter {
    static func loadTestFile(context: NSManagedObjectContext) -> ObservingPlan {
        let planName = "FirstPlan-23-01-26"
        let data = try! Data(contentsOf: Bundle.main.url(forResource: planName, withExtension: "json")!)
        let json = try! JSONDecoder().decode([ObjectData].self, from: data)
        return importJSON(from: json, into: context, withName: planName)
    }
    
    static func importJSON(from data: [ObjectData], into context: NSManagedObjectContext, withName name: String) -> ObservingPlan {
        let plan = ObservingPlan(context: context)
        plan.created = .now
        plan.name = name
        
        for objectData in data {
            let object = PlanObject(context: context)
            object.id = objectData.id
            object.magnitude = Double(objectData.magnitude) ?? 0
            object.type = objectData.objecttype
            object.ra = Double(objectData.ra) ?? 0
            object.dec = Double(objectData.dec) ?? 0
            object.constellation = objectData.constellation
            object.commonName = objectData.name
            
            plan.addToObjects(object)
        }
        
        return plan
    }
}
