//
//  Day21.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/21/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day21: NSObject {

    func getCharacterAt(arr: [[Character]], x: Int, y: Int) -> Character {
        return arr[y][x]
    }
    
    func printArray(arr: [[Character]]) {
        for line in arr {
            print (line)
        }
    }
    
    func getArray(str: String) -> [[Character]] {
        var arr: [[Character]] = []
        let lines = str.split(separator: "/")
        for line in lines {
            var lineArray: [Character] = []
            for c in line {
                lineArray.append(c)
            }
            
            arr.append(lineArray)
        }
        
        return arr
    }
    
    func rotateArrayClockwise(original: [[Character]]) -> [[Character]] {
        var arr: [[Character]] = []
        let size = original.count
        for x in 0..<size {
            var lineArray: [Character] = []
            for y in stride(from: size - 1, through: 0, by: -1) {
                lineArray.append(getCharacterAt(arr: original, x: x, y: y))
            }
            
            arr.append(lineArray)
        }
        
        return arr
    }
    
    func flipArrayVertical(original: [[Character]]) -> [[Character]] {
        var arr: [[Character]] = []
        let size = original.count
        for y in 0..<size {
            var lineArray: [Character] = []
            for x in stride(from: size - 1, through: 0, by: -1) {
                lineArray.append(getCharacterAt(arr: original, x: x, y: y))
            }
            
            arr.append(lineArray)
        }
        
        return arr
    }
    
    func flipArrayHorizontal(original: [[Character]]) -> [[Character]] {
        var arr: [[Character]] = []
        let size = original.count
        for y in stride(from: size - 1, through: 0, by: -1) {
            var lineArray: [Character] = []
            for x in 0..<size {
                lineArray.append(getCharacterAt(arr: original, x: x, y: y))
            }
            
            arr.append(lineArray)
        }
        
        return arr
    }
    
    public func solve() {
        let puzzleInput = Day21PuzzleInput.puzzleInput_test1
        //let puzzleInput = Day21PuzzleInput.puzzleInput
        let puzzleStartingPattern = Day21PuzzleInput.puzzleInput_startingPattern
        
        let p = getArray(str: puzzleStartingPattern)
        printArray(arr: p)
        print (" ")
        let q = rotateArrayClockwise(original: p)
        printArray(arr: q)
        print (" ")
        let r = rotateArrayClockwise(original: q)
        printArray(arr: r)
        print (" ")
        let s = flipArrayVertical(original: p)
        printArray(arr: s)
        print (" ")
        let t = flipArrayHorizontal(original: p)
        printArray(arr: t)

        let part1Solution = solvePart1(str: puzzleInput)
        print ("Part 1 solution: \(part1Solution)")
        
        //let part2Solution = solvePart2(str: puzzleInput)
        //print ("Part 2 solution: \(part2Solution)")
    }
    
    func solvePart1(str: String) -> Int {
        return 0
    }
    
}
