//
//  LoginView.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class LoginView: UIView {

    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
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

    let loginButton = PrimaryButton()

    override func layoutSubviews() {
        setupStyles()
        addViews()
    }

    private func addViews() {
        addSubviews([mainImage, emailTextField, passwordTextField, loginButton])
        setupConstraits()
    }

    private func setupConstraits() {
        mainImage.topToTop(of: self, margin: 120*Dimen.heightMultiplier)
        mainImage.centerHorizontal(to: self)
        mainImage.heightTo(260*Dimen.heightMultiplier)

        emailTextField.topToBottom(of: mainImage, margin: 115*Dimen.heightMultiplier)
        emailTextField.centerHorizontal(to: self)
        emailTextField.leadingToLeading(of: self, margin: Dimen.leadingMargin)
        emailTextField.heightTo(Dimen.textFieldHeight)

        passwordTextField.topToBottom(of: emailTextField, margin: 20*Dimen.heightMultiplier)
        passwordTextField.centerHorizontal(to: self)
        passwordTextField.leadingToLeading(of: self, margin: Dimen.leadingMargin)
        passwordTextField.heightTo(Dimen.textFieldHeight)

        loginButton.bottomToBottom(of: self, margin: 40*Dimen.heightMultiplier)
        loginButton.centerHorizontal(to: self)
        loginButton.leadingToLeading(of: self, margin: Dimen.leadingMargin)
        loginButton.heightTo(Dimen.buttonHeight)
    }
}

extension LoginView: Stylable {
    func setupColors() {
        backgroundColor = .background
    }

    func setupImages() {
        mainImage.image = .happyMusic
    }

    func setupTexts() {
        loginButton.setup(title: "ENTRAR")
    }
}
