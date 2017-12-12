//
//  Day11.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/11/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day11: NSObject {

    public func solve() {
        //let puzzleInput = Day11PuzzleInput.puzzleInput_test4
        let puzzleInput = Day11PuzzleInput.puzzleInput
        
        let solution = solvePuzzle(str: puzzleInput)
        print ("Part 1 solution: \(solution.0)")
        print ("Part 2 solution: \(solution.1)")
    }
    
    func calculateDistance(pAxisSlash: Int, pAxisBackslash: Int, pAxisPipe: Int) -> Int {
        var axisSlash = pAxisSlash
        var axisBackslash = pAxisBackslash
        var axisPipe = pAxisPipe
        
        // reduce the steps
        // ne and s
        while axisSlash < 0 && axisPipe > 0 {
            axisSlash += 1
            axisPipe -= 1
            axisBackslash += 1
        }
        
        // nw and s
        while axisBackslash < 0 && axisPipe > 0 {
            axisBackslash += 1
            axisPipe -= 1
            axisSlash += 1
        }
        
        // se and n
        while axisBackslash > 0 && axisPipe < 0 {
            axisBackslash -= 1
            axisPipe += 1
            axisSlash -= 1
        }
        
        // sw and n
        while axisSlash > 0 && axisPipe < 0 {
            axisSlash -= 1
            axisPipe += 1
            axisBackslash -= 1
        }
        
        // ne and nw
        while axisSlash < 0 && axisBackslash < 0 {
            axisSlash += 1
            axisBackslash += 1
            axisPipe -= 1
        }
        
        // se and sw
        while axisSlash > 0 && axisBackslash > 0 {
            axisSlash -= 1
            axisBackslash -= 1
            axisPipe += 1
        }
        
        return abs(axisSlash) + abs(axisBackslash) + abs(axisPipe)
    }
    
    func solvePuzzle(str: String) -> (Int, Int) {
        var axisBackslash = 0   // \
        var axisSlash = 0       // /
        var axisPipe = 0        // |
        var maxDistance = 0
        let stepArray = str.split(separator: ",")
        for step in stepArray {
            if step == "n" {
                axisPipe -= 1
            } else if step == "nw" {
                axisBackslash -= 1
            } else if step == "ne" {
                axisSlash -= 1
            } else if step == "s" {
                axisPipe += 1
            } else if step == "sw" {
                axisSlash += 1
            } else if step == "se" {
                axisBackslash += 1
            }
            
            let currentDistance = calculateDistance(pAxisSlash: axisSlash, pAxisBackslash: axisBackslash, pAxisPipe: axisPipe)
            if currentDistance > maxDistance {
                maxDistance = currentDistance
            }
        }
        
        return (calculateDistance(pAxisSlash: axisSlash, pAxisBackslash: axisBackslash, pAxisPipe: axisPipe), maxDistance)
    }
    
}
