//
//  HomeViewController.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import UIKit

class HomeViewController: UIViewController {

    private let homeView = HomeView.init()
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
    }
}

