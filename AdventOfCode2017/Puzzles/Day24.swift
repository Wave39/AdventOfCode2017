//
//  Day24.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/24/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day24: NSObject {

    typealias Bridge = [Int]
    
    struct Component {
        var leftPort: Int = 0
        var rightPort: Int = 0
        static func == (lhs: Component, rhs: Component) -> Bool {
            return (lhs.leftPort == rhs.leftPort && lhs.rightPort == rhs.rightPort) || (lhs.leftPort == rhs.rightPort && lhs.rightPort == rhs.leftPort)
        }
        static func != (lhs: Component, rhs: Component) -> Bool {
            return !(lhs == rhs)
        }

    }
    
    typealias Components = [Component]
    
    var bridges: [Bridge] = []
    
    public func solve() {
        //let puzzleInput = Day24PuzzleInput.puzzleInput_test1
        let puzzleInput = Day24PuzzleInput.puzzleInput

        let components = parsePuzzleInput(str: puzzleInput)
        
        let solution = solvePuzzle(components: components)
        print ("Part 1 solution: \(solution.0)")
        print ("Part 2 solution: \(solution.1)")
    }

    func parsePuzzleInput(str: String) -> Components {
        var retval: [Component] = []
        for line in str.split(separator: "\n") {
            let port = line.split(separator: "/")
            var comp = Component()
            comp.leftPort = Int(String(port[0]))!
            comp.rightPort = Int(String(port[1]))!
            retval.append(comp)
        }
        
        return retval
    }
    
    func solvePuzzle(components: Components) -> (Int, Int) {
        bridges = []
        let startingComponents = components.filter { $0.leftPort == 0 || $0.rightPort == 0 }
        for c in startingComponents {
            buildBridge(oldBridge: [], components: components, component: c)
        }
        
        var part1Strength = 0
        var part2Length = 0
        var part2Strength = 0
        for b in bridges {
            let bridgeStrength = b.reduce(0, +)
            if bridgeStrength > part1Strength {
                part1Strength = bridgeStrength
            }
            
            if b.count > part2Length {
                part2Length = b.count
                part2Strength = bridgeStrength
            } else if b.count == part2Length {
                if bridgeStrength > part2Strength {
                    part2Strength = bridgeStrength
                }
            }
        }
        
        return (part1Strength, part2Strength)
    }
    
    func buildBridge(oldBridge: Bridge, components: Components, component: Component) {
        var newBridge = oldBridge
        let searchValue = newBridge.last ?? 0
        if component.leftPort == searchValue {
            newBridge.append(component.leftPort)
            newBridge.append(component.rightPort)
        } else {
            newBridge.append(component.rightPort)
            newBridge.append(component.leftPort)
        }
        
        bridges.append(newBridge)
        let newComponents = components.filter { $0 != component }
        let nextComponents = newComponents.filter { $0.leftPort == newBridge.last! || $0.rightPort == newBridge.last! }
        for c in nextComponents {
            buildBridge(oldBridge: newBridge, components: newComponents, component: c)
        }
    }
    
}
