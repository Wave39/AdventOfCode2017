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
    
    func substring(from: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: self.count - from)
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
    
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map { result.range(at: $0).location != NSNotFound
                ? nsString.substring(with: result.range(at: $0))
                : ""
            }
        }
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func convertRange(startIdx: Int, endIdx: Int) -> Range<String.Index> {
        let idx0 = self.index(self.startIndex, offsetBy: startIdx)
        let idx1 = self.index(self.startIndex, offsetBy: endIdx)
        return idx0..<idx1
    }
    
    func removeCharacters(startIdx: Int, charLength: Int) -> String {
        var newStr = self
        for _ in 0..<charLength {
            let idx0 = newStr.index(newStr.startIndex, offsetBy: startIdx)
            newStr.remove(at: idx0)
        }

        return newStr
    }
    
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }

    func convertHexToBinary() -> String {
        var retval = ""
        
        for c in self {
            var b = String(Int(String(c), radix: 16)!, radix: 2)
            while b.count < 4 {
                b = "0" + b
            }
            
            retval = retval + b
        }
        
        return retval
    }
    
    func convertBinaryToHashesAndDots() -> String {
        var retval = ""
        
        for c in self {
            if c == "0" {
                retval += "."
            } else {
                retval += "#"
            }
        }
        
        return retval
    }
    
    func replace(index: Int, newChar: Character) -> String {
        var chars = Array(self)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }

}
