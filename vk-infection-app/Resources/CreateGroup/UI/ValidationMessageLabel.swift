//
//  inputFieldMessageLabel.swift
//  vk-infection-app
//
//  Created by Sofya Olekhnovich on 25.03.2024.
//

import UIKit

class ValidationMessageLabel: UILabel {

    init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textAlignment = .left
        textColor = .red
        font = .systemFont(ofSize: 12)
        numberOfLines = 0
    }
}
