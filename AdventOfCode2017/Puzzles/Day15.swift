//
//  Day15.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/15/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day15: NSObject {

    public func solve() {
        //let puzzleInput = Day15PuzzleInput.puzzleInput_test1
        let puzzleInput = Day15PuzzleInput.puzzleInput
        
        let puzzleInputMatrix = puzzleInput.parseIntoMatrix()
        let initialGenerators = (Int(puzzleInputMatrix[0][4])!, Int(puzzleInputMatrix[1][4])!)

        let part1Solution = solvePart1(initialGenerators: initialGenerators)
        print ("Part 1 solution: \(part1Solution)")
        
        let part2Solution = solvePart2(initialGenerators: initialGenerators)
        print ("Part 2 solution: \(part2Solution)")
    }

    func getNextGenerators(generators: (Int, Int)) -> (Int, Int) {
        let a = (generators.0 * 16807) % 2147483647
        let b = (generators.1 * 48271) % 2147483647
        return (a, b)
    }
    
    func generatorsMatch(generatorA: Int, generatorB: Int) -> Bool {
        let matchA = generatorA & 65535
        let matchB = generatorB & 65535
        return matchA == matchB
    }
    
    func generatorsMatch(generators: (Int, Int)) -> Bool {
        return generatorsMatch(generatorA: generators.0, generatorB: generators.1)
    }
    
    func solvePart1(initialGenerators: (Int, Int)) -> Int {
        let iterations = 40000000
        var matchCount = 0
        var generators = initialGenerators
        
        for _ in 0..<iterations {
            generators = getNextGenerators(generators: generators)
            if generatorsMatch(generators: generators) {
                matchCount += 1
            }
        }
        
        return matchCount
    }
    
    func solvePart2(initialGenerators: (Int, Int)) -> Int {
        let iterations = 5000000
        var generators = initialGenerators
        var aGenerators: [Int] = []
        var bGenerators: [Int] = []
        while aGenerators.count < iterations || bGenerators.count < iterations {
            generators = getNextGenerators(generators: generators)
            if generators.0 % 4 == 0 {
                aGenerators.append(generators.0)
            }
            
            if generators.1 % 8 == 0 {
                bGenerators.append(generators.1)
            }
        }
        
        var matchCount = 0
        for idx in 0..<iterations {
            if generatorsMatch(generatorA: aGenerators[idx], generatorB: bGenerators[idx]) {
                matchCount += 1
            }
        }
        
        return matchCount
    }
    
}
