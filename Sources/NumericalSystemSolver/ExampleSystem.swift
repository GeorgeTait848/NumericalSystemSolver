//
//  GolfBallSystem.swift
//  Golf Ball Modelling
//
//  Created by George Tait on 10/10/2023.
//

import Foundation

public struct GolfBallSystem: TimeIndependantSimulatableSystem {
    
    
    var x: Double
    var y: Double
    var xdot: Double
    var ydot: Double
    var k: Double
    var windSpeed: Double
    var windAngle: Double
    
    public init (x: Double, y: Double, ballSpeed: Double, launchAngle: Double, k: Double, windSpeed: Double, windAngle: Double) {
        
        self.x = x
        self.y = y
        self.xdot = ballSpeed*cos(launchAngle)
        self.ydot = ballSpeed*sin(launchAngle)
        self.k = k
        self.windSpeed = windSpeed
        self.windAngle = windAngle
    }
    
    public init (ballSpeed: Double, launchAngle: Double, k: Double, windSpeed: Double, windAngle: Double) {
        self.init(x: 0, y: 0, ballSpeed: ballSpeed, launchAngle: launchAngle, k: k, windSpeed: windSpeed, windAngle: windAngle)
    }
    
    
    public func getCurrentDerivatives(currentState: NumericalSystemSolver.DoubleVector, placeholder: Double = 0.0) -> NumericalSystemSolver.DoubleVector {
        
        let wx = windSpeed * cos(windAngle)
        let wy = windSpeed * sin(windAngle)
        
        let xddot = -k*(xdot - wx) * sqrt((xdot + wx)*(xdot + wx) + (ydot + wy)*(ydot + wy))
        let yddot = -k*(ydot - wy) * sqrt((xdot + wx)*(xdot + wx) + (ydot + wy)*(ydot + wy)) - 9.81
        
        return DoubleVector(elements: [xdot, xddot, ydot, yddot])
    }
    
    public func getCurrentState() -> NumericalSystemSolver.DoubleVector {
        return DoubleVector(elements: [x, xdot, y, ydot])
    }
    
    public mutating func reassignProperties(newState: NumericalSystemSolver.DoubleVector) {
        x = newState.elements[0]
        xdot = newState.elements[1]
        y = newState.elements[2]
        ydot = newState.elements[3]
    }
    
    
}
