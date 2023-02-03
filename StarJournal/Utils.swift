//
//  Utils.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/28/23.
//

import UIKit

extension UIApplication {
    static let keyWindow = keyWindowScene?.windows.filter(\.isKeyWindow).first
    static let keyWindowScene = shared.connectedScenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
}

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
    
    static func hmsToDeg(h: Double, m: Double, s: Double) -> Double {
        return 15 * (h + m/60 + s/(60*60))
    }
    
    static func dmsToDeg(v: String, d: Double, m: Double, s: Double) -> Double {
        let sign: Double = v == "+" ? 1 : -1
        
        let deg = d + m/60 + s/(60*60)
        return sign * deg
    }
}

extension UIImage {
    func mergeWith(topImage: UIImage) -> UIImage {
        let bottomImage = self

        UIGraphicsBeginImageContext(size)


        let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
        bottomImage.draw(in: areaSize)

        topImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)

        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return mergedImage
    }
}
