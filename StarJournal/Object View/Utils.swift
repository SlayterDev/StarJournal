//
//  Utils.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/28/23.
//

import Foundation

extension Double {
    func toDms() -> String {
        let deg = abs(self)
        let d = floor(deg)
        var rem = deg - d
        var m = rem * 60
        rem = m - floor(m)
        m = floor(m)
        let s = floor(rem * 60)
        
        return "\(self < 0 ? "-" : "")\(Int(d))º\(Int(m))'\(Int(s))\""
    }
    
    func toHms() -> String {
        let deg = abs(self)
        let h = floor(deg / 15)
        let m = floor(((deg / 15) - h) * 60)
        let s = ((((deg / 15) - h) * 60) - m) * 60
        
        return "\(self < 0 ? "-" : "")\(Int(h))h\(Int(m))'\(String(format: "%.1f", s))\""
    }
}
