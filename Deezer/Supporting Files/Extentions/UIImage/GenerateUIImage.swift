//
//  GenerateUIImage.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

extension UIImage {
    public static var mello: UIImage {
        imageBuilder("mello")
    }
    public static var happyMusic: UIImage {
        imageBuilder("happy_music")
    }
    public static var search: UIImage {
        UIImage(systemName: "magnifyingglass")!
    }
    public static var radioFilled: UIImage {
        UIImage(systemName: "circle.inset.filled")!
    }
    public static var radioEmpty: UIImage {
        UIImage(systemName: "circle")!
    }
}
