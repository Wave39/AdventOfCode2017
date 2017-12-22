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
    
    func getPixelCount(arr: [[Character]]) -> Int {
        var retval = 0
        for y in 0..<arr.count {
            for x in 0..<arr[y].count {
                if arr[y][x] == "#" {
                    retval += 1
                }
            }
        }

        return retval
    }
    
    func printArray(arr: [[Character]]) {
        for line in arr {
            var s = ""
            for c in line {
                s += String(c)
            }
            
            print (s)
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
    
    func getString(arr: [[Character]]) -> String {
        var retval = ""
        for y in 0..<arr.count {
            for x in 0..<arr[y].count {
                retval += String(getCharacterAt(arr: arr, x: x, y: y))
            }
            
            if y != (arr.count - 1) {
                retval += "/"
            }
        }
        
        return retval
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
        
        let part1Solution = solvePart1(str: (puzzleStartingPattern, puzzleInput))
        print ("Part 1 solution: \(part1Solution)")
        
        //let part2Solution = solvePart2(str: puzzleInput)
        //print ("Part 2 solution: \(part2Solution)")
    }
    
    func solvePart1(str: (String, String)) -> Int {
        var rules: Dictionary<String, String> = [:]
        for line in str.1.split(separator: "\n") {
            let arr = line.split(separator: "=")
            let leftArr = getArray(str: String(arr[0]))
            let rightStr = String(arr[1]).removeCharacters(startIdx: 0, charLength: 2)
            rules[getString(arr: leftArr)] = rightStr
            var rotateArr = rotateArrayClockwise(original: leftArr)   // rotated 90
            rules[getString(arr: rotateArr)] = rightStr
            rotateArr = rotateArrayClockwise(original: rotateArr)   // rotated 180
            rules[getString(arr: rotateArr)] = rightStr
            rotateArr = rotateArrayClockwise(original: rotateArr)   // rotated 270
            rules[getString(arr: rotateArr)] = rightStr
            var flipArr = flipArrayVertical(original: leftArr)
            rules[getString(arr: flipArr)] = rightStr
            flipArr = flipArrayHorizontal(original: leftArr)
            rules[getString(arr: flipArr)] = rightStr
        }

        var pattern = getArray(str: str.0)
        for _ in 0..<2 {
        }
        
        return getPixelCount(arr: pattern)
    }
    
}
