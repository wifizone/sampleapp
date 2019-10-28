//
//  Point.swift
//  SampleAnimationApp
//
//  Created by Антон Полуянов on 27/10/2019.
//  Copyright © 2019 Антон Полуянов. All rights reserved.
//

import Foundation

/// UIkit независимая точка
struct Point {
    
    /// Координата x
    var x: Double
    
    /// Координата y
    var y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}
