//
//  Day12.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/12/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day12: NSObject {
    
    public func solve() {
        //let puzzleInput = Day12PuzzleInput.puzzleInput_test1
        let puzzleInput = Day12PuzzleInput.puzzleInput
        
        let solution = solvePuzzle(str: puzzleInput)
        print ("Part 1 solution: \(solution)")
        //print ("Part 2 solution: \(solution.1)")
    }

    func findRow(lineArray: [[String]], rowNumber: Int) -> [String] {
        for l in lineArray {
            if Int(l[0])! == rowNumber {
                return l
            }
        }
        
        return []
    }
    
    func addRow(set: Set<Int>, queue: inout Array<Int>, row: [String]) {
        for idx in 2..<(row.count) {
            let s = row[idx].replacingOccurrences(of: ",", with: "")
            let i = Int(s)!
            if !set.contains(i) {
                queue.append(i)
            }
        }
    }
    
    func findGroup(lineArray: [[String]], programNumber: Int) -> Set<Int> {
        var programSet: Set<Int> = Set()
        var programQueue: Array<Int> = []
        let firstRow = findRow(lineArray: lineArray, rowNumber: programNumber)
        let firstElement = Int(firstRow[0])!
        programSet.insert(firstElement)
        let row = findRow(lineArray: lineArray, rowNumber: firstElement)
        addRow(set: programSet, queue: &programQueue, row: row)
        
        //print ("Program set is now \(programSet)")
        //print ("Program queue is now \(programQueue)")
        
        while programQueue.count > 0 {
            let element = programQueue.first!
            //print ("Adding \(element) to program set")
            programSet.insert(element)
            
            let row = findRow(lineArray: lineArray, rowNumber: element)
            addRow(set: programSet, queue: &programQueue, row: row)
            
            programQueue.removeFirst()
            //print ("Program set is now \(programSet)")
            //print ("Program queue is now \(programQueue)")
        }
        
        return programSet
    }

    func solvePuzzle(str: String) -> Int {
        var lineArray: [[String]] = []
        var programGroups: [Set<Int>] = []

        lineArray = str.parseIntoMatrix()
        
        let group = findGroup(lineArray: lineArray, programNumber: 0)
        
        return group.count
    }
    
}
