//
//  Day14.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/14/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day14: NSObject {

    var elementArray: [Int] = []

    public func solve() {
        let puzzleInput = Day14PuzzleInput.puzzleInput_test1
        //let puzzleInput = Day14PuzzleInput.puzzleInput
        
        let solution = solvePuzzle(str: puzzleInput)
        print ("Part 1 solution: \(solution.0)")
        print ("Part 2 solution: \(solution.1)")
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
    
    func calculateKnotHash(str: String) -> String {
        setUpElementArray(ctr: 256)
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
        
    func solvePuzzle(str: String) -> (Int, Int) {
        var knotHashArray: [String] = []
        var usedCount = 0
        for idx in 0...127 {
            let k = str + "-" + String(idx)
            let knotHash = calculateKnotHash(str: k).convertHexToBinary()
            knotHashArray.append(knotHash)
            let ones = knotHash.asciiArray.filter { $0 == 49 }
            usedCount += ones.count
        }

        return (usedCount, 2)
    }
}
