//
//  Day06.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/6/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day06: NSObject {

    public func solve() {
        let puzzleInput = Day06PuzzleInput.puzzleInput
        
        let solution = solveInput(str: puzzleInput)
        print ("Part 1 solution: \(solution.0)")
        print ("Part 2 solution: \(solution.1)")
    }
    
    func parseInput(str: String) -> [Int] {
        var retval: [Int] = []
        let lineArray = str.split(separator: " ")
        for line in lineArray {
            retval.append(Int(line)!)
        }
        
        return retval
    }

    func findLargestIndex(arr: [Int]) -> Int {
    
        let sortedArray = arr.sorted()
        let largestValue = sortedArray.last
        for idx in 0..<arr.count {
            if arr[idx] == largestValue {
                return idx
            }
        }
        
        return NSNotFound
    }
    
    func arrayToString(arr: [Int]) -> String {
        var retval = ""
        for i in arr {
            retval += (String(i) + " ")
        }
        
        return retval
    }
    
    func processArray(arr: inout [Int]) {
        let largeIdx = findLargestIndex(arr: arr)
        let v = arr[largeIdx]
        arr[largeIdx] = 0
        for i in 1...v {
            let nextIdx = (largeIdx + i) % arr.count
            arr[nextIdx] = arr[nextIdx] + 1
        }
    }
    
    func solveInput(str: String) -> (Int, Int) {
        var processCounter = 0
        var loopCounter = 0
        var memoryBanks = parseInput(str: str)
        var dict: Dictionary<String, Int> = [ arrayToString(arr: memoryBanks): 0 ]
        var stayInLoop = true
        while stayInLoop {
            processArray(arr: &memoryBanks)
            processCounter += 1
            
            let memoryString = arrayToString(arr: memoryBanks)
            if dict[memoryString] == nil {
                dict[memoryString] = processCounter
            } else {
                stayInLoop = false
                loopCounter = processCounter - dict[memoryString]!
            }
        }
        
        return (processCounter, loopCounter)
    }
    
}
