//
//  Day04.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/4/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day04: NSObject {

    public func solve() {
        let puzzleInput = Day04PuzzleInput.puzzleInput
        
        let part1Solution = solveString(str: puzzleInput, checkForAnagrams: false)
        print ("Part 1 solution: \(part1Solution)")
        
        let part2Solution = solveString(str: puzzleInput, checkForAnagrams: true)
        print ("Part 2 solution: \(part2Solution)")
    }
    
    func solveString(str: String, checkForAnagrams: Bool) -> Int {
        var total = 0
        let matrix = str.parseIntoMatrix()
        for line in matrix {
            var s = Set<String>()
            for element in line {
                let theElement: String
                if (checkForAnagrams) {
                    theElement = String(element.sorted())
                } else {
                    theElement = element
                }
                
                s.insert(theElement)
            }
            
            if s.count == line.count {
                total = total + 1
            }
        }
        
        return total
    }
    
}
