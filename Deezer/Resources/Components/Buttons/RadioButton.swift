//
//  RadioButton.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import UIKit

enum RadioState {
    case filled
    case empty
}

class RadioButton: UIButton {
    var status: RadioState?
    var title: String?

    func setup(status: RadioState, title: String) {
        self.status = status
        self.title = title
        setupStyles()
    }

    func setup(checked: Bool) {
        status = checked ? .filled : .empty
        setupImages()
    }
}

extension RadioButton: Stylable {
    func setupImages() {
        let image: UIImage = status == .filled ? .radioFilled : .radioEmpty
        setImage(image, for: .normal)
    }

    func setupTexts() {
        setTitle(title, for: .normal)
    }

    func setupColors() {
        tintColor = .lightGray
    }
}
