//
//  Day25.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/25/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

struct Substep {
    var newValue: Int = 0
    var newDirection: Int = 0
    var continueWith: Int = 0
}

struct Step {
    var ifZero: Substep
    var ifOne: Substep
}

var steps: [Step] = []
var tapeArray: [Int] = []
var stepCount: Int = 0

class Day25: NSObject {

    public func solve() {
        //let puzzleInput = Day25PuzzleInput.puzzleInput_test1
        let puzzleInput = Day25PuzzleInput.puzzleInput
        
        parsePuzzleInput(str: puzzleInput)
        
        let solution = solvePuzzle()
        print ("Part 1 solution: \(solution)")
    }

    func parsePuzzleInput(str: String) {
        steps = []
        let lineArray = str.split(separator: "\n")
        stepCount = Int(String(lineArray[0]))!
        var lineIndex = 1
        while lineIndex < lineArray.count {
            let components = lineArray[lineIndex].split(separator: ",")
            let substep0 = Substep(newValue: Int(String(components[0]))!, newDirection: Int(String(components[1]))!, continueWith: Int(String(components[2]))!)
            let substep1 = Substep(newValue: Int(String(components[3]))!, newDirection: Int(String(components[4]))!, continueWith: Int(String(components[5]))!)
            steps.append(Step(ifZero: substep0, ifOne: substep1))
            lineIndex += 1
        }
    }
    
    func solvePuzzle() -> Int {
        let arraySize = 2_000_000
        var cursorPosition = arraySize / 2
        var state = 0
        tapeArray = []
        for _ in 0..<arraySize {
            tapeArray.append(0)
        }
        
        for _ in 0..<stepCount {
            let step = steps[state]
            if tapeArray[cursorPosition] == 1 {
                tapeArray[cursorPosition] = step.ifOne.newValue
                cursorPosition += step.ifOne.newDirection
                state = step.ifOne.continueWith
            } else {
                tapeArray[cursorPosition] = step.ifZero.newValue
                cursorPosition += step.ifZero.newDirection
                state = step.ifZero.continueWith
            }
        }
        
        let onesArray = tapeArray.filter { $0 == 1 }
        return onesArray.count
    }
    
}
