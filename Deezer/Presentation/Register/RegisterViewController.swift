//
//  RegisterViewController.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class RegisterViewController: UIViewController {

    private let registerView = RegisterView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = registerView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}

extension RegisterViewController: Navigation {
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .lightGray
        navigationController?.navigationBar.tintColor = .background
    }
}
