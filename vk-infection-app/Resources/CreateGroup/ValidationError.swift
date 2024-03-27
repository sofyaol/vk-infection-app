//
//  ValidationError.swift
//  vk-infection-app
//
//  Created by Sofya Olekhnovich on 26.03.2024.
//

import Foundation

enum ValidationError: String {
    case invalidFormat = "Неверный формат"
    case fieldCannotBeEmpty = "Поле не может быть пустым"
}
