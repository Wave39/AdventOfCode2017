//
//  Day09.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/9/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day09: NSObject {

    public func solve() {
        let puzzleInput = Day09PuzzleInput.puzzleInput

        let solution = solvePuzzle(str: puzzleInput)
        print ("Part 1 solution: \(solution.0)")
        print ("Part 2 solution: \(solution.1)")
    }

    func solvePuzzle(str: String) -> (Int, Int) {
        let strWithGarbageRemoved = removeGarbage(str: str)
        let strWithOtherCharactersRemoved = removeOtherCharacters(str: strWithGarbageRemoved.0)
        var level = 0
        var total = 0
        for idx in 0..<strWithOtherCharactersRemoved.count {
            let c = strWithOtherCharactersRemoved.substring(from: idx, to: (idx + 1))
            if c == "{" {
                level += 1
            } else if c == "}" {
                total += level
                level -= 1
            }
        }
        
        return (total, strWithGarbageRemoved.1)
    }
    
    func removeGarbage(str: String) -> (String, Int) {
        var newStr = str
        var garbageCtr = 0
        
        var garbage = findGarbage(str: newStr)
        while garbage.0 != nil {
            garbageCtr += (garbage.1! - garbage.2! * 2 - 2)
            newStr = newStr.removeCharacters(startIdx: garbage.0!, charLength: garbage.1!)
            garbage = findGarbage(str: newStr)
        }
        
        return (newStr, garbageCtr)
    }
    
    func removeOtherCharacters(str: String) -> String {
        let set = CharacterSet(charactersIn: "{}")
        let stripped = str.components(separatedBy: set.inverted).joined()
        return stripped
    }
    
    func findGarbage(str: String) -> (Int?, Int?, Int?) {
        var startIndex: Int?
        startIndex = str.index(of: "<")?.encodedOffset
        if startIndex == nil {
            return (nil, nil, nil)
        }

        var endIndex = startIndex! + 1
        var found = false
        var ignoreMode = false
        var ignoreCounter = 0
        while !found {
            let c = str.substring(from: endIndex, to: (endIndex + 1))
            if ignoreMode {
                ignoreMode = false
            } else {
                if c == ">" {
                    found = true
                    return (startIndex, (endIndex - startIndex! + 1), ignoreCounter)
                } else if c == "!" {
                    ignoreMode = true
                    ignoreCounter += 1
                }
            }
            
            endIndex += 1
        }
    }
    
}
