//
//  HomeView.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import UIKit

class HomeView: UIView {

    let welcomeText = UILabel()
    let profilePicture = UIImageView()
    let searchField: InputTextField = {
        let textfield = InputTextField()
        textfield.setup(type: .search)
        return textfield
    }()
    let singerButton = RadioButton()
    let musicButton = RadioButton()
    let chartsTitle = UILabel()
    let chartsCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        return collection
    }()

    override func layoutSubviews() {
        setupStyles()
        addViews()
    }

    private func addViews() {
        addSubviews([welcomeText, searchField, singerButton, musicButton, chartsTitle, chartsCollectionView])
        setupConstraits()
    }

    private func setupConstraits() {
        welcomeText.topToTop(of: self, margin: 84*Dimen.heightMultiplier)
        welcomeText.leadingToLeading(of: self, margin: 24*Dimen.widthMultiplier)

        searchField.topToBottom(of: welcomeText, margin: 34*Dimen.heightMultiplier)
        searchField.leadingToLeading(of: self, margin: Dimen.leadingMargin)
        searchField.centerHorizontal(to: self)
        searchField.heightTo(Dimen.textFieldHeight)

        singerButton.topToBottom(of: searchField, margin: 20*Dimen.heightMultiplier)
        singerButton.leadingToLeading(of: self, margin: Dimen.leadingMargin)

        musicButton.topToTop(of: singerButton)
        musicButton.leadingToTrailing(of: singerButton, margin: 20*Dimen.widthMultiplier)

        chartsTitle.topToBottom(of: singerButton, margin: 26*Dimen.heightMultiplier)
        chartsTitle.leadingToLeading(of: self, margin: Dimen.leadingMargin)

        chartsCollectionView.topToBottom(of: chartsTitle, margin: 12*Dimen.heightMultiplier)
        chartsCollectionView.leadingToLeading(of: self)
        chartsCollectionView.trailingToTrailing(of: self)
        chartsCollectionView.bottomToBottom(of: self)
    }
}

extension HomeView: Stylable {
    func setupColors() {
        backgroundColor = .background
        welcomeText.textColor = .lightGray
        chartsTitle.textColor = .lightGray
        chartsCollectionView.backgroundColor = .background
    }

    func setupTexts() {
        welcomeText.text = "BEM VINDO FULANO!"
        chartsTitle.text = "MAIS TOCADAS"
        singerButton.setup(status: .filled, title: "CANTOR")
        musicButton.setup(status: .empty, title: "MÚSICA")
    }

    func setupFonts() {
        welcomeText.font = .systemFont(ofSize: 16)
        chartsTitle.font = .systemFont(ofSize: 16)
    }
}
