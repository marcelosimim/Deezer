//
//  RegisterViewModel.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import Foundation

class RegisterViewModel {

    private let registerUseCase: RegisterUseCase

    init(registerUseCase: RegisterUseCase) {
        self.registerUseCase = registerUseCase
    }

    func register(user:User, email:String, password:String, completion: @escaping (Error?) -> ()) {
        registerUseCase.execute(user: user.toUserModel(), email: email, password: password) { error in
            guard let error = error else {
                completion(nil)
                return
            }
            completion(error)
        }
    }
}
