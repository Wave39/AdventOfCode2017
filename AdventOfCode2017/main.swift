//
//  main.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/1/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Foundation

print ("Welcome to BP's Advent Of Code 2017 puzzle solver.")
print ("Make sure to click in the Output window to enter which puzzle you would like to solve.")
print ("")

let defaultPuzzle = 1
var puzzle = 0
while (puzzle < 1 || puzzle > 25) {
    print ("Which puzzle would you like to solve? (Enter a number from 1 to 25, default of \(defaultPuzzle)")
    let response = readLine()
    if (response != "") {
        puzzle = Int(response ?? "0")!
    } else {
        puzzle = defaultPuzzle
        print ("Defaulting to puzzle \(defaultPuzzle)")
    }
}

print ("")
print ("Solving puzzle \(puzzle), please stand by...")

if (puzzle == 1)
{
    let day01 = Day01()
    day01.solve()
}

print ("")
print ("Press Enter to end the puzzle solving session")
let endOfLine = readLine()
