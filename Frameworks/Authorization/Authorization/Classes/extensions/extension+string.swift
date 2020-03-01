//
//  extension+string.swift
//  Base
//
//  Created by Sergey Korobin on 26.02.2020.
//

import Foundation

extension String {

    func isValidEmail() -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.([A-Za-z]){1,50}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

    func isValidPassword() -> Bool {
        let passwordRegex = "([a-z]|[A-Z]|[а-яёА-ЯЁ]|[0-9]){8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }

}
