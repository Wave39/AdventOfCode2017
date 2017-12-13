//
//  Day13.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/13/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day13: NSObject {

    struct Layer {
        var maxDepth: Int = 0
        var currentDepth: Int = 0
        var currentDirection: Int = 1
    }
    
    var layerDictArray: Array<Dictionary<Int, Layer>> = []
    
    public func solve() {
        //let puzzleInput = Day13PuzzleInput.puzzleInput_test1
        let puzzleInput = Day13PuzzleInput.puzzleInput
        
        let solution = solvePuzzle(str: puzzleInput)
        print ("Part 1 solution: \(solution.0)")
        print ("Part 2 solution: \(solution.1)")
    }

    func moveScanners(layerDict: inout Dictionary<Int, Layer>) {
        for k in layerDict.keys {
            let v = layerDict[k]?.currentDepth
            let m = layerDict[k]?.maxDepth
            if v == 0 {
                layerDict[k]?.currentDirection = 1
            } else if v == (m! - 1) {
                layerDict[k]?.currentDirection = -1
            }
            
            let newValue = v! + (layerDict[k]?.currentDirection)!
            layerDict[k]?.currentDepth = newValue
        }
    }
    
    func calculateSeverity(pLayerDict: Dictionary<Int, Layer>, maxLayer: Int, delay: Int) -> Int {
        var currentLayer = 0
        var severity = -1
        
        while currentLayer <= maxLayer {
            let state = layerDictArray[currentLayer + delay]
            let layer = state[currentLayer]
            if layer != nil {
                if layer?.currentDepth == 0 {
                    if severity == -1 {
                        severity = 0
                    }
                    
                    severity += (currentLayer * (layer?.maxDepth)!)
                }
            }
            
            currentLayer += 1
        }
        
        return severity
    }
    
    func solvePuzzle(str: String) -> (Int, Int) {
        let lineArray = str.split(separator: "\n")
        var layerDict: Dictionary<Int, Layer> = [:]
        var maxLayer = 0
        for line in lineArray {
            let elementArray = line.split(separator: ":")
            let k = Int(elementArray[0])!
            var layer = Layer()
            layer.maxDepth = Int(String(elementArray[1]).trim())!
            layerDict[k] = layer
            if k > maxLayer {
                maxLayer = k
            }
        }
        
        let upperLimit = 5000000
        
        // build the layer dictionaries for the first N picoseconds
        for _ in 0...upperLimit {
            layerDictArray.append(layerDict)
            moveScanners(layerDict: &layerDict)
        }
        
        let part1 = calculateSeverity(pLayerDict: layerDict, maxLayer: maxLayer, delay: 0)
        
        var part2 = 0
        while calculateSeverity(pLayerDict: layerDict, maxLayer: maxLayer, delay: part2) != -1 && part2 < upperLimit {
            part2 += 1
        }
        
        return (part1, part2)
    }
    
}
