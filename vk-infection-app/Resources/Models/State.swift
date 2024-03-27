//
//  State.swift
//  vk-infection-app
//
//  Created by Sofya Olekhnovich on 26.03.2024.
//

import Foundation

struct State {
    
    var peopleInfectionTable: [[Bool]]
    var columnsNumber: Int
    var rowsNumber: Int
    
    init(columnsNumber: Int, rowsNumber: Int) {
        self.peopleInfectionTable = [[Bool]]()
        self.columnsNumber = columnsNumber
        self.rowsNumber = rowsNumber
        
        for _ in 0..<rowsNumber {
            peopleInfectionTable.append([Bool](repeating: false, count: columnsNumber))
        }
    }
    
    mutating func infectRandomCellsFrom(healthyNeighbours: [(Int, Int)], infectionFactor: Int) {
        
        if (healthyNeighbours.count == 0) { return }
        
        var numberOfCellsToInfect = Int.random(in: 0...infectionFactor)
        
        while numberOfCellsToInfect  != 0 {
            let randomIndex = Int.random(in: 0..<healthyNeighbours.count)
            let randomCell = healthyNeighbours[randomIndex]
            
            peopleInfectionTable[randomCell.0][randomCell.1] = true
            numberOfCellsToInfect -= 1
        }
    }
    
    mutating func setInfectedPeopleBy(state: State) {
        for i in 0..<rowsNumber {
            for j in 0..<columnsNumber {
                if state.peopleInfectionTable[i][j] {
                    peopleInfectionTable[i][j] = state.peopleInfectionTable[i][j]
                }
            }
        }
    }
}
