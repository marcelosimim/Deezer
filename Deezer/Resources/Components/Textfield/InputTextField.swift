//
//  File.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import Foundation
import UIKit

enum InputTextFieldType {
    case email
    case password
    case confirmPassword
    case search
}

class InputTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    func setup(type: InputTextFieldType) {
        setupStyles()
        switch type {
        case .email:
            setupEmail()
        case .password, .confirmPassword:
            setupPassword()
        case .search:
            break
        }
    }

    private func setupEmail() {
        keyboardType = .emailAddress
        autocapitalizationType = .none
        attributedPlaceholder = NSAttributedString(
            string: "EMAIL",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }

    private func setupPassword() {
        isSecureTextEntry = true
        attributedPlaceholder = NSAttributedString(
            string: "SENHA",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }
}

extension InputTextField: Stylable {
    func setupColors() {
        textColor = .lightGray
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
}

extension InputTextField {
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
