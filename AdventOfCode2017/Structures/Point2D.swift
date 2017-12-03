//
//  Point2D.swift
//  AdventOfCode2017
//
//  Created by Brian Prescott on 12/3/17.
//  Copyright © 2017 Brian Prescott. All rights reserved.
//

import Foundation

struct Point2D: Hashable {
    var x : Int = 0
    var y : Int = 0
    
    var hashValue: Int {
        return "(\(x),\(y))".hashValue
    }
    
    static func == (lhs: Point2D, rhs: Point2D) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
