//
//  GroupModelingViewModel.swift
//  vk-infection-app
//
//  Created by Sofya Olekhnovich on 26.03.2024.
//

import Foundation

class InfectionModelingViewModel {
    
    weak var view: InfectionModelingViewController?
    var infectionModel: InfectionModel
    var state: State
    
    let columnsNumber = 6
    
    // MARK: - Inits
    
    init(infectionModel: InfectionModel) {
        self.infectionModel = infectionModel
        let rowsNumber = Self.calculateNumberOfRows(columnsNumber: columnsNumber, totalElements: infectionModel.groupSize)
        state = State(columnsNumber: columnsNumber, rowsNumber: rowsNumber)
    }
    
    // MARK: - Public funcs
    
    func isInfected(index: Int) -> Bool {
        isInfectedIn(state: state, index: index)
    }
    
    func infect(index: Int) {
        let (row, column) = calculateTableIndex(flatIndex: index, columnsNumber: columnsNumber)
        state.peopleInfectionTable[row][column] = true
    }
    
    func launchTimerForRecalculation() {
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + infectionModel.timeInterval) { [weak self] in
            guard let self = self else { return }
            
            let newState = spreadInfection(currentState: state, infectionFactor: infectionModel.infectionFactor)
            
            DispatchQueue.main.async {
                if let visibleIndexPaths = self.view?.collectionView.indexPathsForVisibleItems {
                    let infectedVisibleIndexPaths = visibleIndexPaths.filter { indexPath in
                        return !self.isInfected(index: indexPath.item) && self.isInfectedIn(state: newState, index: indexPath.item)
                    }
                    self.state.setInfectedPeopleBy(state: newState)
                    self.view?.collectionView.reloadItems(at: infectedVisibleIndexPaths)
                }
            }
            
            self.launchTimerForRecalculation()
        }
    }
    
    // MARK: - Private funcs
    
    private func isInfectedIn(state: State, index: Int) -> Bool {
        let (row, column) = calculateTableIndex(flatIndex: index, columnsNumber: columnsNumber)
        return state.peopleInfectionTable[row][column]
    }
    
    private static func calculateNumberOfRows(columnsNumber: Int, totalElements: Int) -> Int {
        return totalElements / columnsNumber + (totalElements % columnsNumber == 0 ? 0 : 1)
    }
    
    private func calculateTableIndex(flatIndex: Int, columnsNumber: Int) -> (Int, Int) {
        let row = flatIndex / columnsNumber
        let column = flatIndex % columnsNumber
        return (row, column)
    }
    
    private func spreadInfection(currentState: State, infectionFactor: Int) -> State {
        
        var newState = currentState
        
        for row in 0..<currentState.rowsNumber {
            for column in 0..<currentState.columnsNumber {
                if currentState.peopleInfectionTable[row][column] {
                    
                    let neighbours = getNeighbours(row: row, column: column, rowNumber: currentState.rowsNumber, columnNumber: currentState.columnsNumber)
                    let healthyNeighbours = neighbours.filter { neighbour in
                        return !currentState.peopleInfectionTable[neighbour.0][neighbour.1]
                    }
                    
                    newState.infectRandomCellsFrom(healthyNeighbours: healthyNeighbours, infectionFactor: infectionFactor)
                }
            }
        }
        
        return newState
    }
        
    private func getNeighbours(row: Int, column: Int, rowNumber: Int, columnNumber: Int) -> [(Int, Int)] {
        var neighbours: [(Int, Int)] = []
        
        for i in (row - 1)...(row + 1) {
            for j in (column - 1)...(column + 1) {
                if i >= 0 && i < rowNumber && j >= 0 && j < columnNumber && !(i == row && j == column) {
                    neighbours.append((i, j))
                }
            }
        }
        
        return neighbours
    }
    
}
