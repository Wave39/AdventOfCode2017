//
//  StringExtensions.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/1/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Foundation

extension String {
    
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    
    func substring(range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
    
    func parseIntoMatrix() -> [[String]] {
        var allLines : [[String]] = []
        let lineArray = self.split(separator: "\n")
        for line in lineArray {
            var thisLine : [String] = []
            let elementArray = line.split(separator: " ")
            for element in elementArray {
                thisLine.append(String(element))
            }
            
            allLines.append(thisLine)
        }
        
        return allLines
    }
    
}
