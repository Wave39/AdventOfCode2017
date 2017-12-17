//
//  Day16.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/16/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day16: NSObject {

    enum CommandType {
        case Spin
        case Exchange
        case Partner
        case Unknown
    }
    
    struct DanceMove {
        var command: CommandType = .Unknown
        var spinCount: Int = 0
        var exchangeFrom: Int = 0
        var exchangeTo: Int = 0
        var partnerFrom: Character = " "
        var partnerTo: Character = " "
    }
    
    public func solve() {
        //let puzzleInput = Day16PuzzleInput.puzzleInput_test1
        let puzzleInput = Day16PuzzleInput.puzzleInput
        
        let part1Solution = solvePuzzle(puzzleInput: puzzleInput, iterations: 1)
        print ("Part 1 solution: \(part1Solution)")
        
        let part2Solution = solvePuzzle(puzzleInput: puzzleInput, iterations: 1000000000)
        print ("Part 2 solution: \(part2Solution)")
    }

    func swapCharacters(arr: inout [Character], from: Int, to: Int) {
        let t = arr[from]
        arr[from] = arr[to]
        arr[to] = t
    }
    
    func solvePuzzle(puzzleInput: (Int, String), iterations: Int) -> String {
        let numberOfDancers = puzzleInput.0
        let arr = puzzleInput.1.split(separator: ",")
        var danceMoves: [DanceMove] = []
        for move in arr {
            var danceMove = DanceMove()
            let command = move.first!
            let parameters = String(move).substring(from: 1)
            if command == "s" {
                danceMove.command = .Spin
                danceMove.spinCount = Int(parameters)!
            } else if command == "x" {
                danceMove.command = .Exchange
                let values = parameters.split(separator: "/")
                danceMove.exchangeFrom = Int(values[0])!
                danceMove.exchangeTo = Int(values[1])!
            } else if command == "p" {
                danceMove.command = .Partner
                let values = parameters.split(separator: "/")
                danceMove.partnerFrom = Character(String(values[0]))
                danceMove.partnerTo = Character(String(values[1]))
            }
            
            danceMoves.append(danceMove)
        }

        var sequence: [Character] = []
        let a = Character.asciiValue(c: "a")
        for i in 0..<numberOfDancers {
            sequence.append(Character.asciiChar(v: i + a))
        }
        
        var iter = 0
        var resultSet: Set<String> = Set()
        
        while iter < iterations {
            for move in danceMoves {
                if move.command == .Spin {
                    for _ in 0..<move.spinCount {
                        let t = sequence.last!
                        sequence.insert(t, at: 0)
                        sequence.removeLast()
                    }
                } else if move.command == .Exchange {
                    swapCharacters(arr: &sequence, from: move.exchangeFrom, to: move.exchangeTo)
                } else if move.command == .Partner {
                    let idxFrom = sequence.index(of: move.partnerFrom)
                    let idxTo = sequence.index(of: move.partnerTo)
                    swapCharacters(arr: &sequence, from: idxFrom!, to: idxTo!)
                }
            }
            
            if !resultSet.contains(String(sequence)) {
                resultSet.insert(String(sequence))
            } else {
                let loopCount = resultSet.count
                while iter < (iterations - loopCount) {
                    iter += loopCount
                }
            }
            
            iter += 1
        }
        
        return String(sequence)
    }
    
}
