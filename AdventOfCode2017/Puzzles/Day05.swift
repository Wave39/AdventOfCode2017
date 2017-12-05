//
//  Day05.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/5/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day05: NSObject {

    public func solve() {
        let puzzleInput = Day05PuzzleInput.puzzleInput
        
        let part1Solution = solveInput(str: puzzleInput, testForStrangeJump: false)
        print ("Part 1 solution: \(part1Solution)")
        
        let part2Solution = solveInput(str: puzzleInput, testForStrangeJump: true)
        print ("Part 2 solution: \(part2Solution)")
    }

    func parseInput(str: String) -> [Int] {
        var retval: [Int] = []
        let lineArray = str.split(separator: "\n")
        for line in lineArray {
            retval.append(Int(line)!)
        }
        
        return retval
    }
    
    func solveInput(str: String, testForStrangeJump: Bool) -> Int {
        var total = 0
        var programCounter = 0
        
        var instructionArray = parseInput(str: str)

        while programCounter >= 0 && programCounter < instructionArray.count {
            let jumpValue = instructionArray[programCounter]
            let previousProgramCounter = programCounter
            programCounter += jumpValue
            instructionArray[previousProgramCounter] += ((testForStrangeJump && jumpValue >= 3) ? -1 : 1)
            total += 1
        }
        
        return total
    }
    
}
