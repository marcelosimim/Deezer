//
//  LoginViewModel.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

protocol LoginViewModel {
    var emailValue: Observable<String?> { get }
    var passwordValue: Observable<String?> { get }
    var emailValid: Observable<Bool> { get }
    var passwordValid: Observable<Bool> { get }
    var emailHasError: Observable<Bool> { get }
    var passwordHasError: Observable<Bool> { get }
    var isButtonEnabled: Observable<Bool> { get }
    var loginSuccess: Observable<Error?> { get }

    func textFieldDidBeginEditing(type: InputTextFieldType)
    func textFieldShouldReturn(_ text: String?, type: InputTextFieldType)
    func didTapLogin()
    func canLogin()
}

class DefaultLoginViewModel: LoginViewModel {
    var emailValue = Observable<String?>("")
    var passwordValue = Observable<String?>("")
    var emailValid = Observable<Bool>(false)
    var passwordValid = Observable<Bool>(false)
    var emailHasError = Observable<Bool>(false)
    var passwordHasError = Observable<Bool>(false)
    var isButtonEnabled = Observable<Bool>(false)
    var loginSuccess = Observable<Error?>(nil)

    private let loginUseCase: LoginUseCase

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    func textFieldDidBeginEditing(type: InputTextFieldType) {
        if type == .email {
            emailValid.value = false
            emailHasError.value = false
        } else if type == .password {
            passwordValid.value = false
            passwordHasError.value = false
        }
    }

    func textFieldShouldReturn(_ text: String?, type: InputTextFieldType) {
        if type == .email {
            emailValue.value = text
            emailValid.value = isValidEmail(text)
            emailHasError.value = !emailValid.value
        } else if type == .password {
            passwordValue.value = text
            passwordValid.value = !isEmpty(text)
            passwordHasError.value = !passwordValid.value
        }
    }

    func didTapLogin() {
        login(email: emailValue.value!, password: passwordValue.value!)
    }

    func canLogin() {
        isButtonEnabled.value = emailValid.value && passwordValid.value
    }

    private func isValidEmail(_ text: String?) -> Bool {
        guard let text = text else {
            return false
        }
        return text.isValidEmail()
    }

    private func isEmpty(_ text: String?) -> Bool {
        guard let text = text else {
            return false
        }
        return text.isEmpty
    }

    private func login(email: String, password: String) {
        loginUseCase.execute(email: email, password: password) { error in
            self.loginSuccess.value = error
        }
    }
}
