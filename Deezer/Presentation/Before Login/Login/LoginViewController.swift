//
//  LoginViewController.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class LoginViewController: UIViewController {

    private let loginView = LoginView.init()
    private let loginViewModel = AppContainer.shared.resolve(LoginViewModel.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTextFieldDelegate()
        setupNavigationBar()
        setViewModelBinds()
        setupButtons()
    }

    private func setupButtons() {
        loginView.loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }

    private func setViewModelBinds() {
        loginViewModel.emailHasError.bindWithoutFire { hasError in
            hasError ? self.loginView.emailTextField.setInvalidField() : self.loginView.emailTextField.setValidField()
            self.loginViewModel.canLogin()
        }
        loginViewModel.passwordHasError.bindWithoutFire { hasError in
            hasError ? self.loginView.passwordTextField.setInvalidField() : self.loginView.passwordTextField.setValidField()
            self.loginViewModel.canLogin()
        }
        loginViewModel.isButtonEnabled.bindWithoutFire { isEnabled in
            self.loginView.loginButton.isEnabled = isEnabled
        }
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let textField = textField as? InputTextField, let type = textField.type else {
            return true
        }
        loginViewModel.textFieldShouldReturn(textField.text, type: type)
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? InputTextField, let type = textField.type else {
            return
        }
        loginViewModel.textFieldDidBeginEditing(type: type)
    }

    private func setTextFieldDelegate() {
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
}

extension LoginViewController: Navigation {
    @objc private func loginPressed() {
        loginViewModel.didTapLogin()
        loginViewModel.loginSuccess.bindWithoutFire { error in
            guard let error = error else {
                self.navigationController?.pushViewController(HomeViewController.init(), animated: true)
                return
            }
            Alert.alertToCorrect(title: "Erro", message: error.localizedDescription, controller: self)
        }
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .lightGray
    }
}
