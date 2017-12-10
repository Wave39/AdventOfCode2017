//
//  Day10.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/10/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day10: NSObject {

    var elementArray: [Int] = []
    
    public func solve() {
        //let puzzleInput = Day10PuzzleInput.puzzleInput_test1
        let puzzleInput = Day10PuzzleInput.puzzleInput

        let part1Solution = solvePart1(arr: puzzleInput)
        print ("Part 1 solution: \(part1Solution)")
        
        let part2Solution = solvePart2(arr: puzzleInput)
        print ("Part 2 solution: \(part2Solution)")
    }
    
    func reverseElementArray(pos: Int, len: Int) {
        let halfLen = Int(len / 2)
        for idx in 0..<halfLen {
            let idx1 = (pos + idx) % elementArray.count
            let idx2 = (pos + (len - idx - 1)) % elementArray.count
            let t = elementArray[idx1]
            elementArray[idx1] = elementArray[idx2]
            elementArray[idx2] = t
        }
    }
    
    func setUpElementArray(ctr: Int) {
        elementArray = []
        for idx in 0..<ctr {
            elementArray.append(idx)
        }
    }
    
    func solvePart1(arr: Array<Any>) -> Int {
        setUpElementArray(ctr: arr[0] as! Int)
        var currentPosition = 0
        var skipSize = 0
        let inputLengthArray = (arr[1] as! String).split(separator: ",").map { Int($0)! }
        for inputLength in inputLengthArray {
            reverseElementArray(pos: currentPosition, len: inputLength)
            currentPosition += (inputLength + skipSize)
            skipSize += 1
        }

        return elementArray[0] * elementArray[1]
    }
    
    func solvePart2(arr: Array<Any>) -> String {
        setUpElementArray(ctr: arr[0] as! Int)
        
        let str = arr[1] as! String
        var inputLengthArray = str.asciiArray.map { Int($0) }
        inputLengthArray.append(contentsOf: [ 17, 31, 73, 47, 23 ])

        var currentPosition = 0
        var skipSize = 0
        for _ in 0..<64 {
            for inputLength in inputLengthArray {
                reverseElementArray(pos: currentPosition, len: inputLength)
                currentPosition += (inputLength + skipSize)
                skipSize += 1
            }
        }

        var denseHash: [Int] = []
        for i in 0...15 {
            let idx = i * 16
            var v = elementArray[idx]
            for j in 1...15 {
                v = v ^ elementArray[idx + j]
            }
            
            denseHash.append(v)
        }
        
        var knotHash = ""
        for i in denseHash {
            knotHash += ((i <= 15 ? "0" : "") + String(i, radix: 16))
        }
        
        return knotHash
    }
    
}
