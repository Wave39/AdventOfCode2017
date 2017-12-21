//
//  main.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/1/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Foundation

print ("")
print ("Welcome to BP's Advent Of Code 2017 Solution Machine.")
print ("Make sure to click in the Output window to enter which puzzle you would like to solve.")

let defaultPuzzle = 20

var quitApp = false
while !quitApp {
    var puzzle = 0
    while !quitApp && (puzzle < 1 || puzzle > 25) {
        print ("")
        print ("Which puzzle would you like the Solution Machine to solve? (Enter a number from 1 to 25, default of \(defaultPuzzle), or Q to quit)")
        let response = readLine()
        if response == "q" || response == "Q" {
            quitApp = true
        } else if response != "" {
            puzzle = Int(response ?? "0")!
        } else {
            puzzle = defaultPuzzle
            print ("Defaulting to puzzle \(defaultPuzzle)")
        }
    }

    if !quitApp {
        print ("")
        print ("Solving puzzle \(puzzle), please stand by...")

        let start = DispatchTime.now()
        if puzzle == 1 {
            Day01().solve()
        } else if puzzle == 2 {
            Day02().solve()
        } else if puzzle == 3 {
            Day03().solve()
        } else if puzzle == 4 {
            Day04().solve()
        } else if puzzle == 5 {
            Day05().solve()
        } else if puzzle == 6 {
            Day06().solve()
        } else if puzzle == 7 {
            Day07().solve()
        } else if puzzle == 8 {
            Day08().solve()
        } else if puzzle == 9 {
            Day09().solve()
        } else if puzzle == 10 {
            Day10().solve()
        } else if puzzle == 11 {
            Day11().solve()
        } else if puzzle == 12 {
            Day12().solve()
        } else if puzzle == 13 {
            Day13().solve()
        } else if puzzle == 14 {
            Day14().solve()
        } else if puzzle == 15 {
            Day15().solve()
        } else if puzzle == 16 {
            Day16().solve()
        } else if puzzle == 17 {
            Day17().solve()
        } else if puzzle == 18 {
            Day18().solve()
        } else if puzzle == 19 {
            Day19().solve()
        } else if puzzle == 20 {
            Day20().solve()
        }
        
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("Time to evaluate puzzle \(puzzle): \(String(format: "%.3f", timeInterval)) seconds")
    }
}

print ("")
print ("Thanks for checking out my Advent Of Code 2017 Solution Machine.")
