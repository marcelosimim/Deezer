//
//  PrimaryButton.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class PrimaryButton: UIButton {

    func setup(title: String) {
        setupStyles()
        layer.cornerRadius = 5
        setTitle(title, for: .normal)
    }
}

extension PrimaryButton: Stylable {
    func setupColors() {
        backgroundColor = .lightGray
        setTitleColor(.background, for: .normal)
    }
}
