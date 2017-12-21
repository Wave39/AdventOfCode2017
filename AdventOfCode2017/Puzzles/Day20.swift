//
//  Day20.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/20/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day20: NSObject {

    struct XYZ {
        var x = 0
        var y = 0
        var z = 0
    }
    
    struct Particle {
        var particleNumber: Int = -1
        var position: XYZ = XYZ()
        var velocity: XYZ = XYZ()
        var acceleration: XYZ = XYZ()

        func manhattanDistance() -> Int {
            return abs(position.x) + abs(position.y) + abs(position.z)
        }
        
        func positionString() -> String {
            return "\(position.x),\(position.y),\(position.z)"
        }
    }
    
    var particles: [Particle] = []
    
    public func solve() {
        //let puzzleInput = Day20PuzzleInput.puzzleInput_test2
        let puzzleInput = Day20PuzzleInput.puzzleInput
        
        let part1Solution = solvePart1(str: puzzleInput)
        print ("Part 1 solution: \(part1Solution)")
        
        let part2Solution = solvePart2(str: puzzleInput)
        print ("Part 2 solution: \(part2Solution)")
    }
    
    func parseInput(str: String) {
        let itemRegex = "p=<(.\\d*),(.\\d*),(.\\d*)>, v=<(.\\d*),(.\\d*),(.\\d*)>, a=<(.\\d*),(.\\d*),(.\\d*)>"
        particles = []
        let lines = str.split(separator: "\n")
        var ctr = 0
        for line in lines {
            let arr = String(line).matchesInCapturingGroups(pattern: itemRegex)
            var p = Particle()
            p.particleNumber = ctr
            p.position.x = arr[0].toInt()
            p.position.y = arr[1].toInt()
            p.position.z = arr[2].toInt()
            p.velocity.x = arr[3].toInt()
            p.velocity.y = arr[4].toInt()
            p.velocity.z = arr[5].toInt()
            p.acceleration.x = arr[6].toInt()
            p.acceleration.y = arr[7].toInt()
            p.acceleration.z = arr[8].toInt()
            particles.append(p)
            ctr += 1
        }
    }
    
    func findClosestParticle() -> (Int, Int) {
        var closestIndex = -1
        var closestDistance = Int.max
        for idx in 0..<particles.count {
            let dist = particles[idx].manhattanDistance()
            if dist < closestDistance {
                closestDistance = dist
                closestIndex = idx
            }
        }
        
        return (closestIndex, closestDistance)
    }
    
    func advanceParticles() {
        for idx in 0..<particles.count {
            particles[idx].velocity.x += particles[idx].acceleration.x
            particles[idx].velocity.y += particles[idx].acceleration.y
            particles[idx].velocity.z += particles[idx].acceleration.z
            particles[idx].position.x += particles[idx].velocity.x
            particles[idx].position.y += particles[idx].velocity.y
            particles[idx].position.z += particles[idx].velocity.z
        }
    }
    
    func removeCollidedParticles() {
        var particleDict: Dictionary<String, [Int]> = [:]
        var idx = 0
        for p in particles {
            let k = p.positionString()
            if particleDict[k] == nil {
                particleDict[k] = []
            }
            
            particleDict[k]?.append(idx)
            idx += 1
        }
        
        var removalArray: [Int] = []
        for k in particleDict.keys {
            if particleDict[k]!.count > 1 {
                for p in particleDict[k]! {
                    removalArray.append(p)
                }
            }
        }

        if removalArray.count > 0 {
            removalArray = removalArray.sorted { $0 > $1 }
            for idx in removalArray {
                particles.remove(at: idx)
            }
        }
    }
    
    func solvePart1(str: String) -> Int {
        parseInput(str: str)
        
        var lastClosest = -1
        for _ in 0...1000 {
            advanceParticles()
            let c = findClosestParticle()
            if c.0 != lastClosest {
                lastClosest = c.0
            }
        }
        
        let closest = findClosestParticle()
        
        return closest.0
    }
    
    func solvePart2(str: String) -> Int {
        parseInput(str: str)
        removeCollidedParticles()

        for _ in 0...1000 {
            advanceParticles()
            removeCollidedParticles()
        }
        
        return particles.count
    }
    
}
