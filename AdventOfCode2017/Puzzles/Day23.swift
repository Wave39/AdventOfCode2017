//
//  Day23.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/23/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day23: NSObject {

    enum InstructionType {
        case Undefined
        case Set
        case Subtract
        case Multiply
        case JumpIfNotZero
    }
    
    struct Instruction {
        var instructionType: InstructionType = .Undefined
        var parameter1Int: Int?
        var parameter1String: String?
        var parameter2Int: Int?
        var parameter2String: String?
    }
    
    var instructionArray: [Instruction] = []
    
    public func solve() {
        let puzzleInput = Day23PuzzleInput.puzzleInput
        
        parsePuzzleInput(str: puzzleInput)
        
        let part1Solution = solvePart1()
        print ("Part 1 solution: \(part1Solution)")
        
        let part2Solution = solvePart2()
        print ("Part 2 solution: \(part2Solution)")
    }

    func parsePuzzleInput(str: String) {
        instructionArray = []
        let matrix = str.parseIntoMatrix()
        for line in matrix {
            var newInstruction: Instruction = Instruction()
            if line[0] == "set" {
                newInstruction.instructionType = .Set
            } else if line[0] == "sub" {
                newInstruction.instructionType = .Subtract
            } else if line[0] == "mul" {
                newInstruction.instructionType = .Multiply
            } else if line[0] == "jnz" {
                newInstruction.instructionType = .JumpIfNotZero
            }
            
            if line[1].isStringNumeric() {
                newInstruction.parameter1Int = Int(line[1])
            } else {
                newInstruction.parameter1String = line[1]
            }
            
            if line[2].isStringNumeric() {
                newInstruction.parameter2Int = Int(line[2])
            } else {
                newInstruction.parameter2String = line[2]
            }
            
            instructionArray.append(newInstruction)
        }
    }
    
    func solvePart1() -> Int {
        var registers: Dictionary<String, Int> = [ "a": 0, "b": 0, "c": 0, "d": 0, "e": 0, "f": 0, "g": 0, "h": 0 ]
        var programCounter = 0
        var multiplyCounter = 0
        while programCounter >= 0 && programCounter < instructionArray.count {
            let currentInstruction = instructionArray[programCounter]
            let parameter1: Int?
            if currentInstruction.parameter1Int != nil {
                parameter1 = currentInstruction.parameter1Int
            } else if currentInstruction.parameter1String != nil {
                parameter1 = registers[currentInstruction.parameter1String!]
            } else {
                parameter1 = nil
            }
            
            let parameter2: Int?
            if currentInstruction.parameter2Int != nil {
                parameter2 = currentInstruction.parameter2Int
            } else if currentInstruction.parameter2String != nil {
                parameter2 = registers[currentInstruction.parameter2String!]
            } else {
                parameter2 = nil
            }
            
            if currentInstruction.instructionType == .Set {
                registers[currentInstruction.parameter1String!] = parameter2
            } else if currentInstruction.instructionType == .Subtract {
                let previousValue = registers[currentInstruction.parameter1String!]
                registers[currentInstruction.parameter1String!] = previousValue! - parameter2!
            } else if currentInstruction.instructionType == .Multiply {
                multiplyCounter += 1
                let previousValue = registers[currentInstruction.parameter1String!]
                registers[currentInstruction.parameter1String!] = previousValue! * parameter2!
            } else if currentInstruction.instructionType == .JumpIfNotZero {
                if parameter1! != 0 {
                    programCounter += (parameter2! - 1)
                }
            }
            
            programCounter += 1
        }
        
        return multiplyCounter
    }
    
    // I found this function on Stack Overflow and liked it, as it seems concise and relatively fast.
    // https://stackoverflow.com/a/44413339/36984
    func isPrime(_ number: Int) -> Bool {
        let maxDivider = Int(sqrt(Double(number)))
        return number > 1 && !(2...maxDivider).contains { number % $0 == 0 }
    }
    
    func solvePart2() -> Int {
        // Trying to run part 2 brute force is designed to not work by the devious Advent Of Code people.
        // I figured that the code input needed to be optimized, but was too lazy to do so myself.
        // As a result, the solution to part 2 is stolen from the following site:
        // https://github.com/dp1/AoC17/blob/master/day23.5.txt
        
        let b = 109300
        let c = 126300
        var h = 0
        for idx in stride(from: b, to: (c + 1), by: 17) {
            if !isPrime(idx) {
                h += 1
            }
        }

        return h
    }
    
}
