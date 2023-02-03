//
//  MessierParser.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/31/23.
//

import Foundation
import CoreData

struct MessierParser: LineParser {
    func objectType(forStatus status: String) -> String {
        guard let statusInt = Int(status) else {
            return "Unknown"
        }
        
        switch statusInt {
        case 1:
            return "Galaxy"
        case 2:
            return "Neb"
        case 3:
            return "P Neb"
        case 4:
            return "Open"
        case 5:
            return "Globular"
        case 6:
            return "Neb"
        case 9:
            return "Open"
        default:
            return "Unknown"
        }
    }
    
    func parseDelimited(line: [String], context: NSManagedObjectContext) -> CatalogObject {
        let id = "M" + line[0]
        
        // coords
        let rah = Double(line[16]) ?? 0.0
        let ram = Double(line[17]) ?? 0.0
        let ras = Double(line[18]) ?? 0.0
        let ra = Double.hmsToDeg(h: rah, m: ram, s: ras)
        
        let v = line[19]
        let decd = Double(line[20]) ?? 0.0
        let decm = Double(line[21]) ?? 0.0
        let decs = Double(line[22]) ?? 0.0
        let dec = Double.dmsToDeg(v: v, d: decd, m: decm, s: decs)
        
        let constelation = line[23].capitalized
        let magnitude = Double(line[25]) ?? 0.0
        let type = objectType(forStatus: line[27])
        
        let name = line[28]
        
        let obj = CatalogObject(context: context)
        obj.id = id
        obj.ra = ra
        obj.dec = dec
        obj.magnitude = magnitude
        obj.type = type
        obj.constellation = constelation
        obj.name = name
        
        return obj
    }
}
