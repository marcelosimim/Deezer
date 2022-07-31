//
//  RegisterViewModel.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import Foundation

protocol RegisterViewModel {
    var nameValue: Observable<String?> { get }
    var emailValue: Observable<String?> { get }
    var passwordValue: Observable<String?> { get }
    var confirmPasswordValue: Observable<String?> { get }
    var nameValid: Observable<Bool> { get }
    var emailValid: Observable<Bool> { get }
    var passwordValid: Observable<Bool> { get }
    var confirmPasswordValid: Observable<Bool> { get }
    var nameHasError: Observable<Bool> { get }
    var emailHasError: Observable<Bool> { get }
    var passwordHasError: Observable<Bool> { get }
    var confirmPasswordHasError: Observable<Bool> { get }
    var isButtonEnabled: Observable<Bool> { get }
    var registerSuccess: Observable<Error?> { get }
    func textFieldDidBeginEditing(type: InputTextFieldType)
    func textFieldShouldReturn(_ text: String?, type: InputTextFieldType)
    func didTapRegister()
    func canRegister()
}

class DefaultRegisterViewModel: RegisterViewModel {
    var nameValue = Observable<String?>("")
    var emailValue = Observable<String?>("")
    var passwordValue = Observable<String?>("")
    var confirmPasswordValue = Observable<String?>("")
    var nameValid = Observable<Bool>(false)
    var emailValid = Observable<Bool>(false)
    var passwordValid = Observable<Bool>(false)
    var confirmPasswordValid = Observable<Bool>(false)
    var nameHasError = Observable<Bool>(false)
    var emailHasError = Observable<Bool>(false)
    var passwordHasError = Observable<Bool>(false)
    var confirmPasswordHasError = Observable<Bool>(false)
    var isButtonEnabled = Observable<Bool>(false)
    var registerSuccess = Observable<Error?>(nil)
    private let registerUseCase: RegisterUseCase

    init(registerUseCase: RegisterUseCase) {
        self.registerUseCase = registerUseCase
    }

    func didTapRegister() {
        let user = User(fullName: nameValue.value, email: emailValue.value, perfilImage: nil)
        register(user: user, email: emailValue.value!, password: passwordValue.value!)
    }

    func textFieldDidBeginEditing(type: InputTextFieldType) {
        if type == .email {
            emailValid.value = false
            emailHasError.value = false
        } else if type == .password {
            passwordValid.value = false
            passwordHasError.value = false
        } else if type == .confirmPassword {
            confirmPasswordValid.value = false
            confirmPasswordHasError.value = false
        } else if type == .name {
            nameValid.value =  false
            nameHasError.value = false
        }
    }

    func textFieldShouldReturn(_ text: String?, type: InputTextFieldType) {
        if type == .email {
            emailValue.value = text
            emailValid.value = isValidEmail(text)
            emailHasError.value = !emailValid.value
        } else if type == .password {
            passwordValue.value = text
            passwordValid.value = isValidPassword(text)
            passwordHasError.value = !passwordValid.value
        } else if type == .confirmPassword {
            confirmPasswordValue.value = text
            confirmPasswordValid.value = compareTexts()
            confirmPasswordHasError.value = !confirmPasswordValid.value
        } else if type == .name {
            nameValue.value = text
            nameValid.value = !isEmpty(text)
            nameHasError.value = !nameValid.value
        }
    }

    func canRegister() {
         isButtonEnabled.value = nameValid.value && emailValid.value && passwordValid.value && confirmPasswordValid.value
    }

    private func isValidEmail(_ text: String?) -> Bool {
        guard let text = text else {
            return false
        }
        return text.isValidEmail()
    }

    private func isValidPassword(_ text: String?) -> Bool {
        guard let text = text else {
            return false
        }
        return text.count >= 6 ? true : false
    }

    private func compareTexts() -> Bool {
        (passwordValue.value == confirmPasswordValue.value) && isValidPassword(passwordValue.value)
    }

    private func isEmpty(_ text: String?) -> Bool {
        guard let text = text else {
            return false
        }
        return text.isEmpty
    }

    private func register(user:User, email:String, password:String) {
        registerUseCase.execute(user: user.toUserModel(), email: email, password: password) { error in
            self.registerSuccess.value = error
        }
    }
}
