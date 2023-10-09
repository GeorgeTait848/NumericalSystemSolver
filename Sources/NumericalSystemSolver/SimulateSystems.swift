//
//  SimulateSystems.swift
//  modellingPendulums
//
//  Created by George Tait on 15/12/2022.
//

import Foundation


func simulateTimeIndependantSystem<T: TimeIndependantSimulatableSystem> (system: T, timeOfSimulation: Double, relativeTol: Double) -> SimulationDataContainer {
    
    var tempSystem = system
    
    var currentStep = 0.01
    let initialState = tempSystem.getCurrentState()
    var outputData = SimulationDataContainer(data: [])
    outputData.storeSystemDataAtIteration(state: initialState)
    
    var currentTime = 0.0
    
    while currentTime < timeOfSimulation {
        
        let currentState = tempSystem.getCurrentState()
        
        currentStep = adaptStep(f: tempSystem.getCurrentDerivatives(currentState:placeholder:), y: currentState, x: 0, h: currentStep, relativeTol: relativeTol)
        
        tempSystem.updateSystemState(currentState: currentState, step: currentStep)

        outputData.storeSystemDataAtIteration(state: currentState)
        
        currentTime += currentStep
    }
    
    tempSystem.reassignProperties(newState: initialState)
    
    return outputData

}

func simulateTimeIndependantSystem<T: TimeIndependantSimulatableSystem> (system: T, whileCondition: Bool, relativeTol: Double) -> SimulationDataContainer {
    
    var tempSystem = system
    
    var currentStep = 0.01
    let initialState = tempSystem.getCurrentState()
    var outputData = SimulationDataContainer(data: [])
    outputData.storeSystemDataAtIteration(state: initialState)
    
    
    
    while whileCondition {
        
        let currentState = tempSystem.getCurrentState()
        
        currentStep = adaptStep(f: tempSystem.getCurrentDerivatives(currentState:placeholder:), y: currentState, x: 0, h: currentStep, relativeTol: relativeTol)
        
        tempSystem.updateSystemState(currentState: currentState, step: currentStep)

        outputData.storeSystemDataAtIteration(state: currentState)
    }
    
    tempSystem.reassignProperties(newState: initialState)
    
    return outputData

}


func simulateTimeDependantSystem<T: TimeDependantSimulatableSystem> (system: T, timeOfSimulation: Double, relativeTol: Double) -> SimulationDataContainer {
    
    var tempSystem = system
    
    var currentStep = 0.01
    let initialState = tempSystem.getCurrentState()
    var outputData = SimulationDataContainer(data: [])
    outputData.storeSystemDataAtIteration(state: initialState)
    
    var currentTime = 0.0
    
    while currentTime < timeOfSimulation {
        
        let currentState = tempSystem.getCurrentState()
        
        currentStep = adaptStep(f: tempSystem.getCurrentDerivatives(currentState:currentTime:), y: currentState, x: 0, h: currentStep, relativeTol: relativeTol)
        
        tempSystem.updateSystemState(currentState: currentState, currentTime: currentTime, step: currentStep)

        outputData.storeSystemDataAtIteration(state: currentState)
        
        currentTime += currentStep
    }
    
    tempSystem.reassignProperties(newState: initialState)
    
    return outputData

}

func simulateTimeDependantSystem<T: TimeDependantSimulatableSystem> (system: T, whileCondition: Bool, relativeTol: Double) -> SimulationDataContainer {
    
    var tempSystem = system
    
    var currentStep = 0.01
    let initialState = tempSystem.getCurrentState()
    var outputData = SimulationDataContainer(data: [])
    outputData.storeSystemDataAtIteration(state: initialState)
    
    var currentTime = 0.0
    
    while whileCondition {
        
        let currentState = tempSystem.getCurrentState()
        
        currentStep = adaptStep(f: tempSystem.getCurrentDerivatives(currentState:currentTime:), y: currentState, x: 0, h: currentStep, relativeTol: relativeTol)
        
        tempSystem.updateSystemState(currentState: currentState, currentTime: currentTime, step: currentStep)

        outputData.storeSystemDataAtIteration(state: currentState)
        
        currentTime += currentStep
    }
    
    tempSystem.reassignProperties(newState: initialState)
    
    return outputData

}
