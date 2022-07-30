//
//  RegisterView.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class RegisterView: UIView {

    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let nameTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.setup(type: .name)
        return textfield
    }()

    private let emailTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.setup(type: .email)
        return textfield
    }()

    private let passwordTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.setup(type: .password)
        return textfield
    }()

    private let confirmPasswordTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.setup(type: .confirmPassword)
        return textfield
    }()

    let registerButton = PrimaryButton()

    override func layoutSubviews() {
        setupStyles()
        addViews()
    }

    private func addViews() {
        addSubviews([mainImage, nameTextField, emailTextField, passwordTextField, confirmPasswordTextField, registerButton])
        setupConstraits()
    }

    private func setupConstraits() {
        mainImage.topToTop(of: self, margin: 120*Dimen.heightMultiplier)
        mainImage.centerHorizontal(to: self)
        mainImage.heightTo(260*Dimen.heightMultiplier)

        nameTextField.topToBottom(of: mainImage, margin: 80*Dimen.heightMultiplier)
        nameTextField.centerHorizontal(to: self)
        nameTextField.leadingToLeading(of: self, margin: Dimen.leadingMargin)
        nameTextField.heightTo(Dimen.textFieldHeight)

        emailTextField.topToBottom(of: nameTextField, margin: 20*Dimen.heightMultiplier)
        emailTextField.centerHorizontal(to: self)
        emailTextField.leadingToLeading(of: self, margin: Dimen.leadingMargin)
        emailTextField.heightTo(Dimen.textFieldHeight)

        passwordTextField.topToBottom(of: emailTextField, margin: 20*Dimen.heightMultiplier)
        passwordTextField.centerHorizontal(to: self)
        passwordTextField.leadingToLeading(of: self, margin: Dimen.leadingMargin)
        passwordTextField.heightTo(Dimen.textFieldHeight)

        confirmPasswordTextField.topToBottom(of: passwordTextField, margin: 20*Dimen.heightMultiplier)
        confirmPasswordTextField.centerHorizontal(to: self)
        confirmPasswordTextField.leadingToLeading(of: self, margin: Dimen.leadingMargin)
        confirmPasswordTextField.heightTo(Dimen.textFieldHeight)

        registerButton.bottomToBottom(of: self, margin: 40*Dimen.heightMultiplier)
        registerButton.centerHorizontal(to: self)
        registerButton.leadingToLeading(of: self, margin: Dimen.leadingMargin)
        registerButton.heightTo(Dimen.buttonHeight)
    }
}

extension RegisterView: Stylable {
    func setupColors() {
        backgroundColor = .background
    }

    func setupImages() {
        mainImage.image = .happyMusic
    }

    func setupTexts() {
        registerButton.setup(title: "CADASTRAR")
    }
}
