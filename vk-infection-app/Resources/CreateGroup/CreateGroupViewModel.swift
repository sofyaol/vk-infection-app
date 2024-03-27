//
//  CreateGroupViewModel.swift
//  vk-infection-app
//
//  Created by Sofya Olekhnovich on 25.03.2024.
//

import Foundation
import UIKit

class CreateGroupViewModel {
    
    weak var navigationController: UINavigationController?
    
    func launchGroupModeling(groupSize: String?, infectionFactor: String?, timeInterval: String?, handleValidationErrors: ([ValidationError?]) -> Void) {
        var errors: [ValidationError?] = [nil, nil, nil]
        var isValid = true
        
        let groupSize: Int? = getValueFrom(fieldValue: groupSize, validationError: &errors[0])
        let infectionFactor: Int? = getValueFrom(fieldValue: infectionFactor, validationError: &errors[1])
        let timeInterval: Double? = getValueFrom(fieldValue: timeInterval, validationError: &errors[2])
        
        if let groupSize = groupSize,
           let infectionFactor = infectionFactor,
           let timeInterval = timeInterval {
            let infectionModel = InfectionModel(groupSize: groupSize, infectionFactor: infectionFactor, timeInterval: timeInterval)
            let infectionModelingViewController = InfectionModelingViewController(viewModel: InfectionModelingViewModel(infectionModel: infectionModel))
            navigationController?.pushViewController(infectionModelingViewController, animated: true)
        } else {
            handleValidationErrors(errors)
        }
    }
    
    func getValueFrom<T: LosslessStringConvertible>(fieldValue: String?, validationError: inout ValidationError?) -> T? {
        guard let value = fieldValue else {
            validationError = .fieldCannotBeEmpty
            return nil
        }
        
        guard !value.isEmpty else {
            validationError = .fieldCannotBeEmpty
            return nil
        }
        
        guard let valueT = T(value) else {
            validationError = .invalidFormat
             return nil
        }
        
        return valueT
    }
    
    func getDoubleValueFrom(fieldValue: String?, validationError: inout ValidationError?) -> Double? {
        guard let value = fieldValue else {
            validationError = .fieldCannotBeEmpty
            return nil
        }
        
        guard !value.isEmpty else {
            validationError = .fieldCannotBeEmpty
            return nil
        }
        
        guard let valueInt = Double(value) else {
            validationError = .invalidFormat
             return nil
        }
        
        return valueInt
    }
}
