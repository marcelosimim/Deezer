//
//  InitialViewController.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class InitialViewController: UIViewController {

    private let initialView = InitialView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = initialView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
        setupButtons()
    }

    private func setupButtons() {
        initialView.loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }
}

extension InitialViewController: Navigation {
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .background
    }
    
    @objc private func loginPressed() {
        navigationController?.pushViewController(LoginViewController.init(), animated: true)
    }
}
