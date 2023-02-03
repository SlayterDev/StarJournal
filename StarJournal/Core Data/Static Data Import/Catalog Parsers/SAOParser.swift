//
//  HYGParser.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/31/23.
//

import Foundation
import CoreData

class SAOParser: LineParser {
    func parseDelimited(line: [String], context: NSManagedObjectContext) -> CatalogObject {
        let id = "SAO" + line[3]
        
        // coords
        let rah = Double(line[4]) ?? 0.0
        let ram = floor(Double(line[5]) ?? 0.0)
        let ras = ((Double(line[5]) ?? 0.0) - ram) * 60
        let ra = Double.hmsToDeg(h: rah, m: ram, s: ras)
        
        let v = (Int(line[6]) ?? 0) < 0 ? "-" : "+"
        let decd = Double(line[6]) ?? 0.0
        let decm = floor(Double(line[7]) ?? 0.0)
        let decs = ((Double(line[7]) ?? 0.0) - decm) * 60
        let dec = Double.dmsToDeg(v: v, d: decd, m: decm, s: decs)
        
        let constelation = line[9].capitalized
        let magnitude = Double(line[8].components(separatedBy: ",")[0]) ?? 0.0
        let type = !line[1].isEmpty ? "Dbl" : "Star"
        
        let name = line[0]
        
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
