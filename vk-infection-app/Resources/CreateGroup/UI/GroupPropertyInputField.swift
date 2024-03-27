//
//  GroupPropertyInputField.swift
//  vk-infection-app
//
//  Created by Sofya Olekhnovich on 25.03.2024.
//

import UIKit

class GroupPropertyInputField: UITextField {

    init(placeholder: String) {
        super.init(frame: CGRect.zero)
        setup(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(placeholder: String) {
        self.placeholder = placeholder
        borderStyle = .roundedRect
    }
}
