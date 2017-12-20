//
//  Day19.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/19/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day19: NSObject {

    enum Direction {
        case UP
        case DOWN
        case LEFT
        case RIGHT
    }
    
    var routingDiagram: [[Character]] = []
    
    public func solve() {
        //let puzzleInput = Day19PuzzleInput.puzzleInput_test1
        let puzzleInput = Day19PuzzleInput.puzzleInput
        
        routingDiagram = parsePuzzleInput(str: puzzleInput)
        
        let solution = solvePuzzle()
        print ("Part 1 solution: \(solution.0)")
        print ("Part 2 solution: \(solution.1)")
    }
    
    func characterAt(x: Int, y: Int) -> Character {
        return routingDiagram[y][x]
    }
    
    func parsePuzzleInput(str: String) -> [[Character]] {
        let lines = str.split(separator: "~")
        var lineArray: [[Character]] = []
        for line in lines {
            var charArray: [Character] = []
            for char in line {
                charArray.append(char)
            }
            
            lineArray.append(charArray)
        }
        
        return lineArray
    }
    
    func advance(direction: Direction, x: inout Int, y: inout Int) {
        if direction == .UP {
            y -= 1
        } else if direction == .DOWN {
            y += 1
        } else if direction == .LEFT {
            x -= 1
        } else if direction == .RIGHT {
            x += 1
        }
    }
    
    func solvePuzzle() -> (String, Int) {
        var currentX = routingDiagram[0].index(of: "|")!
        var currentY = 0
        var currentDirection = Direction.DOWN
        var leaveLoop = false
        var sequence = ""
        var stepCounter = -1    // first step is technically the 0th step
        while !leaveLoop {
            stepCounter += 1
            let c = characterAt(x: currentX, y: currentY)
            if c == " " {
                leaveLoop = true
            } else if c == "+" {
                // change direction
                if currentDirection == .UP || currentDirection == .DOWN {
                    let c2 = characterAt(x: currentX - 1, y: currentY)
                    if c2 == " " {
                        currentDirection = .RIGHT
                    } else {
                        currentDirection = .LEFT
                    }
                } else {
                    let c2 = characterAt(x: currentX, y: currentY - 1)
                    if c2 == " " {
                        currentDirection = .DOWN
                    } else {
                        currentDirection = .UP
                    }
                }
                
                advance(direction: currentDirection, x: &currentX, y: &currentY)
            } else if c == "|" || c == "-" {
                // continue in the current direction
                advance(direction: currentDirection, x: &currentX, y: &currentY)
            } else {
                // hit a letter, check to see if it is the end
                sequence += String(c)
                advance(direction: currentDirection, x: &currentX, y: &currentY)
            }
        }
        
        return (sequence, stepCounter)
    }
    
}
