//
//  DefaultRegisterUseCase.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

final class DefaultRegisterUseCase: RegisterUseCase {

    private let firebaseAuthRepository: FirebaseAuthRepository

    init(firebaseAuthRepository: FirebaseAuthRepository) {
        self.firebaseAuthRepository = firebaseAuthRepository
    }

    func execute(user: UserModel, email: String, password: String, completion: @escaping (Error?) -> Void) {
        firebaseAuthRepository.register(user: user, email: email, password: password, completion: completion)
    }
}
