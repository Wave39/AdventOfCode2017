//
//  Day17.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/17/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day17: NSObject {

    public func solve() {
        //let puzzleInputPart1 = Day17PuzzleInput.puzzleInput_test1
        let puzzleInputPart1 = Day17PuzzleInput.puzzleInput_part1
        let puzzleInputPart2 = Day17PuzzleInput.puzzleInput_part2

        let part1Solution = solvePart1(puzzleInput: puzzleInputPart1)
        print ("Part 1 solution: \(part1Solution)")
        
        let part2Solution = solvePart2(puzzleInput: puzzleInputPart2)
        print ("Part 2 solution: \(part2Solution)")
    }
    
    func createBuffer(step: Int, maxValue: Int) -> [Int] {
        var currentIndex = 0
        var buffer: [Int] = [ 0 ]
        for idx in 1...maxValue {
            currentIndex = (currentIndex + step) % idx + 1
            buffer.insert(idx, at: currentIndex)
        }
        
        return buffer
    }
    
    func solvePart1(puzzleInput: (Int, Int, Int)) -> Int {
        let step = puzzleInput.0
        let maxValue = puzzleInput.1
        let searchValue = puzzleInput.2
        let buffer = createBuffer(step: step, maxValue: maxValue)
        let idx = buffer.index(of: searchValue)
        return buffer[idx! + 1]
    }
    
    func solvePart2(puzzleInput: (Int, Int, Int)) -> Int {
        let step = puzzleInput.0
        let maxValue = puzzleInput.1
        var retval = 0
        var nextIndex = 0
        for idx in 1...maxValue {
            nextIndex = (nextIndex + step) % idx + 1
            if nextIndex == 1 {
                retval = idx
            }
        }
        
        return retval
    }
    
}
