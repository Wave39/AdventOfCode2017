//
//  Day07.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/7/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Program {
    var name: String = ""
    var weight = 0
    var towerWeight = 0
    var otherPrograms: [String] = []
}

class Day07: NSObject {

    var puzzleInput: [Program] = []
    
    public func solve() {
        let puzzleInputString = Day07PuzzleInput.puzzleInput_test1
        puzzleInput = parseInput(str: puzzleInputString)
        calculateTowerWeights()
        
        let solution = solveInput()
        print ("Part 1 solution: \(solution)")
        //print ("Part 2 solution: \(solution.1)")
    }

    func parseInput(str: String) -> [Program] {
        var retval: [Program] = []
        let lineArray = str.split(separator: "\n")
        for line in lineArray {
            let program = Program()
            let a1 = line.split(separator: "(")
            program.name = String(a1[0]).trim()
            let a2 = a1[1].split(separator: ")")
            program.weight = Int(a2[0])!
            if a2.count > 1 {
                let otherPrograms = String(a2[1]).trim()
                if otherPrograms.count > 0 {
                    program.otherPrograms = parseAdditionalPrograms(str: otherPrograms)
                }
            }
            
            retval.append(program)
        }
        
        return retval
    }

    func calculateTowerWeights() {
        for p in puzzleInput {
            p.towerWeight = towerWeight(program: p.name)
        }
    }
    
    func parseAdditionalPrograms(str: String) -> [String] {
        var retval: [String] = []
        
        var s = str.replacingOccurrences(of: "-> ", with: "")
        s = s.replacingOccurrences(of: ",", with: "")
        for x in s.split(separator: " ") {
            retval.append(String(x))
        }
        
        return retval
    }
    
    func findProgramInOtherPrograms(programToFind: String) -> String {
        for p in puzzleInput {
            if p.otherPrograms.count > 0 {
                for op in p.otherPrograms {
                    if programToFind == op {
                        return p.name
                    }
                }
            }
        }
        
        return ""
    }
    
    func findProgram(programToFind: String) -> Program? {
        for p in puzzleInput {
            if programToFind == p.name {
                return p
            }
        }
        
        return nil
    }
    
    func towerWeight(program: String) -> Int {
        let parent = findProgram(programToFind: program)!
        
        var retval = parent.weight
        if parent.otherPrograms.count > 0 {
            for op in parent.otherPrograms {
                retval += towerWeight(program: op)
            }
        }
        
        return retval
    }
    
    func solveInput() -> String {
        for p in puzzleInput {
            if p.otherPrograms.count > 0 {
                let parent = findProgramInOtherPrograms(programToFind: p.name)
                if parent.count == 0 {
                    return p.name
                }
            }
        }
        
        return ""
    }
}
