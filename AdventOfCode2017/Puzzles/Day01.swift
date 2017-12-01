//
//  Day01.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/1/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

public class Day01: NSObject {

    public func solve() {
        let puzzleInput = Day01PuzzleInput.puzzleInput
        
        let part1 = solveString(str: puzzleInput, jumpAhead: 1)
        print ("Part 1 solution: \(part1)")
        
        let part2 = solveString(str: puzzleInput, jumpAhead: (puzzleInput.count / 2))
        print ("Part 2 solution: \(part2)")
    }
    
    public func solveString(str: String, jumpAhead: Int) -> Int {
        var total = 0
        for idx in 0..<str.count {
            let c1 = str.substring(from:idx, to:idx+1)
            var idx2 = idx + jumpAhead
            if idx2 > (str.count - 1) {
                idx2 = idx2 - str.count
            }
            
            let c2 = str.substring(from:idx2, to:idx2+1)
            
            if (c1 == c2) {
                total = total + Int(c1)!
            }
        }
        
        return total
    }
    
}
