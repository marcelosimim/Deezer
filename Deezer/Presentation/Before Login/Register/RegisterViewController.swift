//
//  RegisterViewController.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

class RegisterViewController: UIViewController {

    private let registerView = RegisterView.init()
    private let registerViewModel = AppContainer.shared.resolve(RegisterViewModel.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = registerView
        setTextFieldDelegate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        setViewModelBinds()
        setupButtons()
    }

    private func setupButtons() {
        registerView.registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
    }

    private func setViewModelBinds() {
        registerViewModel.nameHasError.bindWithoutFire { hasError in
            hasError ? self.registerView.nameTextField.setInvalidField() : self.registerView.nameTextField.setValidField()
            self.registerViewModel.canRegister()
        }
        registerViewModel.emailHasError.bindWithoutFire { hasError in
            hasError ? self.registerView.emailTextField.setInvalidField() : self.registerView.emailTextField.setValidField()
            self.registerViewModel.canRegister()
        }
        registerViewModel.passwordHasError.bindWithoutFire { hasError in
            hasError ? self.registerView.passwordTextField.setInvalidField() : self.registerView.passwordTextField.setValidField()
            self.registerViewModel.canRegister()
        }
        registerViewModel.confirmPasswordHasError.bindWithoutFire { hasError in
            hasError ? self.registerView.confirmPasswordTextField.setInvalidField() : self.registerView.confirmPasswordTextField.setValidField()
            self.registerViewModel.canRegister()
        }
        registerViewModel.isButtonEnabled.bindWithoutFire { isEnabled in
            self.registerView.registerButton.isEnabled = isEnabled
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let textField = textField as? InputTextField, let type = textField.type else {
            return true
        }
        registerViewModel.textFieldShouldReturn(textField.text, type: type)
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? InputTextField, let type = textField.type else {
            return
        }
        registerViewModel.textFieldDidBeginEditing(type: type)
    }

    private func setTextFieldDelegate() {
        registerView.nameTextField.delegate = self
        registerView.emailTextField.delegate = self
        registerView.passwordTextField.delegate = self
        registerView.confirmPasswordTextField.delegate = self
    }
}

extension RegisterViewController: Navigation {
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .lightGray
    }

    @objc private func registerPressed() {
        registerViewModel.didTapRegister()
        registerViewModel.registerSuccess.bindWithoutFire { error in
            guard let error = error else {
                self.navigationController?.pushViewController(HomeViewController.init(), animated: true)
                return
            }
            Alert.alertToCorrect(title: "Erro", message: error.localizedDescription, controller: self)
        }
    }
}
