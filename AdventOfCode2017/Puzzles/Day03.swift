//
//  Day03.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/3/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day03: NSObject {

    public func solve() {
        let puzzleInput = Day03PuzzleInput.puzzleInput
        
        let part1Array = buildPart1Spiral(limit: puzzleInput)
        let part1LastElement = part1Array.last
        let part1Solution = abs((part1LastElement?.x)!) + abs((part1LastElement?.y)!)
        print ("Part 1 solution: \(part1Solution)")
        
        let part2Solution = buildPart2Spiral(limit: puzzleInput)
        print ("Part 2 solution: \(part2Solution)")
    }
    
    enum ADVANCE_DIRECTION {
        case UP
        case DOWN
        case LEFT
        case RIGHT
    }
    
    func buildPart1Spiral(limit: Int) -> Array<Point2D> {
        var leftExtreme = 0
        var rightExtreme = 0
        var topExtreme = 0
        var bottomExtreme = 0
        var currentPosition = Point2D(x: 0, y: 0)
        
        var advanceDirection = ADVANCE_DIRECTION.RIGHT
        
        var dict: Dictionary<Int, Point2D> = [:]
        var arr: Array<Point2D> = []
        var idx = 1
        while idx <= limit {
            dict[idx] = currentPosition
            arr.append(currentPosition)
            
            if advanceDirection == .RIGHT {
                currentPosition.x = currentPosition.x + 1
                if currentPosition.x > rightExtreme {
                    rightExtreme = currentPosition.x
                    advanceDirection = .UP
                }
            } else if advanceDirection == .UP {
                currentPosition.y = currentPosition.y - 1
                if currentPosition.y < topExtreme {
                    topExtreme = currentPosition.y
                    advanceDirection = .LEFT
                }
            } else if advanceDirection == .LEFT {
                currentPosition.x = currentPosition.x - 1
                if currentPosition.x < leftExtreme {
                    leftExtreme = currentPosition.x
                    advanceDirection = .DOWN
                }
            } else if advanceDirection == .DOWN {
                currentPosition.y = currentPosition.y + 1
                if currentPosition.y > bottomExtreme {
                    bottomExtreme = currentPosition.y
                    advanceDirection = .RIGHT
                }
            }
            
            idx = idx + 1
        }
        
        return arr
    }

    func sumAdjacentEntries(dict: Dictionary<Point2D, Int>, origin: Point2D) -> Int {
        var total = 0
        
        var positions: Array<Point2D> = []
        for idx in (origin.x - 1)...(origin.x + 1) {
            positions.append(Point2D(x: idx, y: origin.y - 1))
            positions.append(Point2D(x: idx, y: origin.y + 1))
        }
        
        positions.append(Point2D(x: origin.x - 1, y: origin.y))
        positions.append(Point2D(x: origin.x + 1, y: origin.y))

        for p in positions {
            if dict[p] != nil {
                total = total + dict[p]!
            }
        }
        
        return total
    }
    
    func buildPart2Spiral(limit: Int) -> Int {
        var leftExtreme = 0
        var rightExtreme = 0
        var topExtreme = 0
        var bottomExtreme = 0
        var currentPosition = Point2D(x: 0, y: 0)
        
        var advanceDirection = ADVANCE_DIRECTION.RIGHT
        
        var dict: Dictionary<Point2D, Int> = [:]
        var cellValue = 0
        while cellValue <= limit {
            cellValue = sumAdjacentEntries(dict: dict, origin: currentPosition)
            if cellValue == 0 {
                cellValue = 1
            }
            
            dict[currentPosition] = cellValue
            
            if advanceDirection == .RIGHT {
                currentPosition.x = currentPosition.x + 1
                if currentPosition.x > rightExtreme {
                    rightExtreme = currentPosition.x
                    advanceDirection = .UP
                }
            } else if advanceDirection == .UP {
                currentPosition.y = currentPosition.y - 1
                if currentPosition.y < topExtreme {
                    topExtreme = currentPosition.y
                    advanceDirection = .LEFT
                }
            } else if advanceDirection == .LEFT {
                currentPosition.x = currentPosition.x - 1
                if currentPosition.x < leftExtreme {
                    leftExtreme = currentPosition.x
                    advanceDirection = .DOWN
                }
            } else if advanceDirection == .DOWN {
                currentPosition.y = currentPosition.y + 1
                if currentPosition.y > bottomExtreme {
                    bottomExtreme = currentPosition.y
                    advanceDirection = .RIGHT
                }
            }
        }
        
        return cellValue
    }

}
