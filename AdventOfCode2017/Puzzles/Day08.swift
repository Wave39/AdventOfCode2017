//
//  Day08.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/8/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day08: NSObject {

    var puzzleInput: [[String]] = []
    
    public func solve() {
        let puzzleInputString = Day08PuzzleInput.puzzleInput
        puzzleInput = puzzleInputString.parseIntoMatrix()
        
        let solution = solvePuzzle()
        print ("Part 1 solution: \(solution.0)")
        print ("Part 2 solution: \(solution.1)")
    }

    func highValue(dict: Dictionary<String, Int>) -> Int {
        var retval = 0
        for k in dict.keys {
            if dict[k]! > retval {
                retval = dict[k]!
            }
        }
        
        return retval
    }
    
    func solvePuzzle() -> (Int, Int) {
        var highestValue = 0
        var dict: Dictionary<String, Int> = [:]
        for line in puzzleInput {
            let register = line[0]
            let opcode = line[1]
            let incValue = (opcode == "inc" ? Int(line[2]) : -(Int(line[2])!))!
            let testRegister = line[4]
            let condition = line[5]
            let conditionValue = Int(line[6])!
            if dict[register] == nil {
                dict[register] = 0
            }
            
            if dict[testRegister] == nil {
                dict[testRegister] = 0
            }
            
            let testRegisterValue = dict[testRegister]!
            var doIncDec: Bool
            switch condition {
            case "==":
                doIncDec = (testRegisterValue == conditionValue)
            case "!=":
                doIncDec = (testRegisterValue != conditionValue)
            case "<":
                doIncDec = (testRegisterValue < conditionValue)
            case "<=":
                doIncDec = (testRegisterValue <= conditionValue)
            case ">":
                doIncDec = (testRegisterValue > conditionValue)
            case ">=":
                doIncDec = (testRegisterValue >= conditionValue)
            default:
                doIncDec = false
            }
            
            if doIncDec {
                dict[register] = dict[register]! + incValue
            }
            
            let highestValueNow = highValue(dict: dict)
            if highestValueNow > highestValue {
                highestValue = highestValueNow
            }
        }
        
        return (highValue(dict: dict), highestValue)
    }
    
}
