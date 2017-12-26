//
//  Day25PuzzleInput.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/25/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Cocoa

class Day25PuzzleInput: NSObject {

    static let puzzleInput_test1 =
"""
6
1,1,1,0,-1,1
1,-1,0,1,1,0
"""
    
//"""
//Begin in state A.
//Perform a diagnostic checksum after 6 steps.
//
//In state A:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state B.
//  If the current value is 1:
//    - Write the value 0.
//    - Move one slot to the left.
//    - Continue with state B.
//
//In state B:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the left.
//    - Continue with state A.
//  If the current value is 1:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state A.
//"""
    
    static let puzzleInput =
    
"""
12173597
1,1,1,0,-1,2
1,-1,0,1,1,3
1,1,0,0,-1,4
1,1,0,0,1,1
1,-1,5,1,-1,2
1,1,3,1,1,0
"""
    
//"""
//Begin in state A.
//Perform a diagnostic checksum after 12173597 steps.
//
//In state A:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state B.
//  If the current value is 1:
//    - Write the value 0.
//    - Move one slot to the left.
//    - Continue with state C.
//
//In state B:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the left.
//    - Continue with state A.
//  If the current value is 1:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state D.
//
//In state C:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state A.
//  If the current value is 1:
//    - Write the value 0.
//    - Move one slot to the left.
//    - Continue with state E.
//
//In state D:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state A.
//  If the current value is 1:
//    - Write the value 0.
//    - Move one slot to the right.
//    - Continue with state B.
//
//In state E:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the left.
//    - Continue with state F.
//  If the current value is 1:
//    - Write the value 1.
//    - Move one slot to the left.
//    - Continue with state C.
//
//In state F:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state D.
//  If the current value is 1:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state A.
//"""
    
}
