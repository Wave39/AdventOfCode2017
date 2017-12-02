//
//  Day02.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/2/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day02: NSObject {

    public func solve() {
        let puzzleInput = Day02PuzzleInput.puzzleInput
        
        let part1 = solvePart1(str: puzzleInput)
        print ("Part 1 solution: \(part1)")
        
        let part2 = solvePart2(str: puzzleInput)
        print ("Part 2 solution: \(part2)")
    }
    
    public func solvePart1(str: String) -> Int {
        var total = 0
        let matrix = str.parseIntoMatrix()
        for line in matrix {
            var minValue = Int.max
            var maxValue = 0
            for element in line {
                let elementInt = Int(element)!
                if elementInt < minValue {
                    minValue = elementInt
                }
                
                if elementInt > maxValue {
                    maxValue = elementInt
                }
                
            }
            
            total = total + (maxValue - minValue)
        }
        
        return total
    }

    func findEvenlyDivisibleIntegers(arr: [String]) -> (Int, Int) {
        for i in 0...(arr.count - 2) {
            for j in (i + 1)...(arr.count - 1) {
                var e1 = Int(arr[i])!
                var e2 = Int(arr[j])!
                if e1 < e2 {
                    let t = e1
                    e1 = e2
                    e2 = t
                }
                
                if (e1 % e2 == 0) {
                    return (e1, e2)
                }
            }
        }
        
        return (0, 0)
    }
    
    public func solvePart2(str: String) -> Int {
        var total = 0
        let matrix = str.parseIntoMatrix()
        for line in matrix {
            let ints = findEvenlyDivisibleIntegers(arr: line)
            total = total + (ints.0 / ints.1)
        }
        
        return total
    }
    
}
