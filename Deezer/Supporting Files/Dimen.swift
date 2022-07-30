//
//  Dimen.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import Foundation
import UIKit

class Dimen {
    public static let deviceHeight = UIScreen.main.bounds.height
    public static let deviceWidth = UIScreen.main.bounds.width
    public static let heightMultiplier: CGFloat = deviceHeight/812
    public static let widthMultiplier: CGFloat = deviceWidth/375
    public static let leadingMargin: CGFloat = 38*widthMultiplier
    public static let buttonHeight: CGFloat = 42*heightMultiplier
}
