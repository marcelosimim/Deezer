//
//  PrimaryButton.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class PrimaryButton: UIButton {

    func setup(title: String, isEnabled: Bool = true) {
        setupStyles()
        layer.cornerRadius = 5
        setTitle(title, for: .normal)
        self.isEnabled = isEnabled
    }
}

extension PrimaryButton: Stylable {
    func setupColors() {
        backgroundColor = .lightGray
        setTitleColor(.background, for: .normal)
    }

    open override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}
