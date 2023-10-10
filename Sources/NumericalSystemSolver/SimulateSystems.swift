//
//  SimulateSystems.swift
//  modellingPendulums
//
//  Created by George Tait on 15/12/2022.
//

import Foundation


public func simulateTimeIndependantSystem<T: TimeIndependantSimulatableSystem> (system: inout T, timeOfSimulation: Double, relativeTol: Double) -> SimulationDataContainer {
    
    
    
    var currentStep = 0.01
    let initialState = system.getCurrentState()
    var currentState = initialState
    
    var outputData = SimulationDataContainer(data: [])
    outputData.storeSystemDataAtIteration(state: initialState)
    
    var currentTime = 0.0
    
    while currentTime < timeOfSimulation {
        
        currentStep = adaptStep(f: system.getCurrentDerivatives(currentState:placeholder:), y: currentState, x: 0, h: currentStep, relativeTol: relativeTol)
        updateSystemState(system: &system, step: currentStep)
        
        currentState = system.getCurrentState()
        outputData.storeSystemDataAtIteration(state: currentState)
        
        currentTime += currentStep
    }
    
    system.reassignProperties(newState: initialState)
    
    return outputData

}

public func simulateTimeIndependantSystem<T: TimeIndependantSimulatableSystem> (system: inout T, breakConditionIndexInState: Int, breakConditionOperator: (Double, Double) -> Bool, breakConditionValue: Double, relativeTol: Double) -> SimulationDataContainer {

    
    var currentStep = 0.01
    let initialState = system.getCurrentState()
    var currentState = initialState
    
    var outputData = SimulationDataContainer(data: [])
    outputData.storeSystemDataAtIteration(state: currentState)
    
    var breakCondVariable = currentState.elements[breakConditionIndexInState]
    
    
    while breakConditionOperator(breakCondVariable, breakConditionValue) {
        
        
        currentStep = adaptStep(f: system.getCurrentDerivatives(currentState:placeholder:), y: currentState, x: 0, h: currentStep, relativeTol: relativeTol)
        
        updateSystemState(system: &system, step: currentStep)
        
        currentState = system.getCurrentState()
        outputData.storeSystemDataAtIteration(state: currentState)
        breakCondVariable = currentState.elements[breakConditionIndexInState]
    }
    
    system.reassignProperties(newState: initialState)
    
    return outputData

}


public func simulateTimeDependantSystem<T: TimeDependantSimulatableSystem> (system: inout T, timeOfSimulation: Double, relativeTol: Double) -> SimulationDataContainer {
    
    
    var currentStep = 0.01
    let initialState = system.getCurrentState()
    var currentState = initialState
    
    var outputData = SimulationDataContainer(data: [])
    outputData.storeSystemDataAtIteration(state: initialState)
    
    var currentTime = 0.0
    
    while currentTime < timeOfSimulation {
        
        currentStep = adaptStep(f: system.getCurrentDerivatives(currentState:currentTime:), y: currentState, x: currentTime, h: currentStep, relativeTol: relativeTol)
        
        updateSystemState(system: &system, currentTime: currentTime, step: currentStep)
        
        currentState = system.getCurrentState()
        outputData.storeSystemDataAtIteration(state: currentState)
        
        currentTime += currentStep
    }
    
    system.reassignProperties(newState: initialState)
    
    return outputData

}

public func simulateTimeDependantSystem<T: TimeDependantSimulatableSystem> (system: inout T, breakConditionIndexInState: Int, breakConditionOperator: (Double, Double) -> Bool, breakConditionValue: Double, relativeTol: Double) -> SimulationDataContainer {

    var currentStep = 0.01
    var currentTime = 0.0
    
    let initialState = system.getCurrentState()
    var currentState = initialState
    
    var outputData = SimulationDataContainer(data: [])
    outputData.storeSystemDataAtIteration(state: initialState)
    
    var breakConditionVariable = initialState.elements[breakConditionIndexInState]

    while breakConditionOperator(breakConditionVariable, breakConditionValue) {

        currentStep = adaptStep(f: system.getCurrentDerivatives(currentState:currentTime:), y: currentState, x: currentTime, h: currentStep, relativeTol: relativeTol)
        updateSystemState(system: &system, currentTime: currentTime, step: currentStep)

        currentState = system.getCurrentState()
        outputData.storeSystemDataAtIteration(state: currentState)
        currentTime += currentStep
        
        breakConditionVariable = currentState.elements[breakConditionIndexInState]
    }

    system.reassignProperties(newState: initialState)

    return outputData

}


public func updateSystemState<T: TimeIndependantSimulatableSystem> (system: inout T, step: Double) {
    
    let newState = rungeKuttaFourthOrder(f: system.getCurrentDerivatives(currentState:placeholder:), y: system.getCurrentState(), x: 0, h: step)
    
    system.reassignProperties(newState: newState)
    
}

public func updateSystemState<T: TimeDependantSimulatableSystem> (system: inout T, currentTime: Double, step: Double) {
    
    let newState = rungeKuttaFourthOrder(f: system.getCurrentDerivatives(currentState:currentTime:), y: system.getCurrentState(), x: currentTime, h: step)
    
    system.reassignProperties(newState: newState)
    
}
