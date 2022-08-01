//
//  UIColor+Deezer.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

extension UIColor {
    public static func colorBuilder(_ colorName: String) -> UIColor {
        guard let color = UIColor(named: colorName) else {
            return .clear
        }
        return color
    }
}
