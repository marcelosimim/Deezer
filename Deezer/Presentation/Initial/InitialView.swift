//
//  InitialView.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class InitialView: UIView {

    private let mainImage = UIImageView()
    private let mainTitle = UILabel()
    let loginButton = PrimaryButton()
    let registerButton = SecondaryButton()

    override func layoutSubviews() {
        setupStyles()
        addViews()
    }

    private func addViews() {
        addSubviews([mainImage, mainTitle, loginButton, registerButton])
        setupConstraits()
    }

    private func setupConstraits() {
        mainImage.topToTop(of: self, margin: 164*Dimen.heightMultiplier)
        mainImage.centerHorizontal(to: self)

        mainTitle.topToBottom(of: mainImage, margin: 62*Dimen.heightMultiplier)
        mainTitle.centerHorizontal(to: self)

        loginButton.topToBottom(of: mainTitle, margin: 100*Dimen.heightMultiplier)
        loginButton.leadingToLeading(of: self, margin: Dimen.leadingMargin)
        loginButton.centerHorizontal(to: self)
        loginButton.heightTo(Dimen.buttonHeight)

        registerButton.topToBottom(of: loginButton, margin: 30*Dimen.heightMultiplier)
        registerButton.leadingToLeading(of: self, margin: Dimen.leadingMargin)
        registerButton.centerHorizontal(to: self)
        registerButton.heightTo(Dimen.buttonHeight)
    }
}

extension InitialView: Stylable {
    func setupColors() {
        backgroundColor = .background
        mainTitle.textColor = .lightGray
    }

    func setupImages() {
        mainImage.image = .mello
    }

    func setupFonts() {
        mainTitle.font = .systemFont(ofSize: 48*Dimen.heightMultiplier)
    }

    func setupTexts() {
        mainTitle.text = "DEEZER 2.0"
        loginButton.setup(title: "LOGIN")
        registerButton.setup(title: "CADASTRO")
    }
}
