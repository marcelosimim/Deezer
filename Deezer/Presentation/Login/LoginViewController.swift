//
//  LoginViewController.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class LoginViewController: UIViewController {

    private let loginView = LoginView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        setupNavigationBar()
    }
}

extension LoginViewController: Navigation {
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .lightGray
        navigationController?.navigationBar.tintColor = .background
    }
}
