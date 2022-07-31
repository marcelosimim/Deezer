//
//  File.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import Foundation
import UIKit

enum InputTextFieldType {
    case name
    case email
    case password
    case confirmPassword
    case search
}

class InputTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    var type: InputTextFieldType?

    func setup(type: InputTextFieldType) {
        setupStyles()
        self.type = type
        switch type {
        case .email:
            setupEmail()
        case .password, .confirmPassword:
            setupPassword()
        case .search, .name:
            setupDefaults()
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
        let placeholder = type == .password ? "SENHA" : "CONFIRME A SENHA"
        isSecureTextEntry = true
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }

    private func setupDefaults() {
        let placeholder = type == .name ? "NOME" : "BUSCAR"
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }

    func setValidField() {
        textColor = .lightGray
        layer.borderColor = UIColor.lightGray.cgColor
    }

    func setInvalidField() {
        textColor = .red
        layer.borderColor = UIColor.red.cgColor
    }
}

extension InputTextField: Stylable {
    func setupColors() {
        setValidField()
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
