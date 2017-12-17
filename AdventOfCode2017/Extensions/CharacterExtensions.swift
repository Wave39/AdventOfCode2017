//
//  CharacterExtensions.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/10/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Foundation

extension Character {

    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }

    static func asciiChar(v: Int) -> Character {
        return Character(UnicodeScalar(v)!)
    }
    
    static func asciiValue(c: Character) -> Int {
        let s = String(c).unicodeScalars
        return Int(s[s.startIndex].value)
    }
    
}
