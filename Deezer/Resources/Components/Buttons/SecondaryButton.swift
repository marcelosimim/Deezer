//
//  SecondaryButton.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class SecondaryButton: UIButton {

    func setup(title: String) {
        setupStyles()
        layer.cornerRadius = 5
        setTitle(title, for: .normal)
    }
}

extension SecondaryButton: Stylable {
    func setupColors() {
        setTitleColor(.lightGray, for: .normal)
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
    }
}

