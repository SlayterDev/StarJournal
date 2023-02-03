//
//  CSVParser.swift
//  StarJournal
//
//  Created by Brad Slayter on 1/31/23.
//

import Foundation
import CoreData

protocol LineParser {
    func parseDelimited(line: [String], context: NSManagedObjectContext) -> CatalogObject
}

struct CSVParser {
    static func parse(fromUrl url: URL, lineParser: LineParser,
                      context: NSManagedObjectContext, containsHeaderRow: Bool = true) {
        let delimiter = ","
        var parsedObjects = [CatalogObject]()
        
        do {
            let content = try String(contentsOf: url)
            var lines = content.components(separatedBy: .newlines)
            if containsHeaderRow {
                lines = Array(lines.dropFirst())
            }
            
            for line in lines {
                guard !line.isEmpty else { continue }
                
                var lineValues = [String]()
                if !line.ranges(of: "\"").isEmpty {
                    // Use scanner to parse a line with double quotes
                    var textToScan = line
                    var value: String?
                    var textScanner = Scanner(string: textToScan)
                    
                    while !textScanner.string.isEmpty {
                        if textScanner.string.first == "\"" {
                            _ = textScanner.scanString("\"")
                            value = textScanner.scanUpToString("\"")
                            _ = textScanner.scanString("\"")
                        } else {
                            value = textScanner.scanUpToString(delimiter)
                        }
                        
                        if let value = value {
                            lineValues.append(value)
                        }
                        
                        if textScanner.isAtEnd {
                            textToScan = ""
                        } else {
                            textToScan = String(textScanner.string[textScanner.currentIndex..<textScanner.string.endIndex])
                        }
                        textScanner = Scanner(string: textToScan)
                    }
                } else {
                    lineValues = line.components(separatedBy: delimiter)
                }
                
                parsedObjects.append(lineParser.parseDelimited(line: lineValues, context: context))
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
