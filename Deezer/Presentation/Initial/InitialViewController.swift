//
//  InitialViewController.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class InitialViewController: UIViewController {

    let initialView = InitialView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = initialView
    }
}
