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

    override func layoutSubviews() {
        setupStyles()
        addViews()
    }

    private func addViews() {
        addSubviews([])
        setupConstraits()
    }

    private func setupConstraits() {

    }
}

extension HomeView: Stylable {
    func setupColors() {
        backgroundColor = .background
    }

    func setupImages() {

    }

    func setupTexts() {
       
    }
}
