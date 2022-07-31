//
//  DefaultLoginUseCase.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

final class DefaultLoginUseCase: LoginUseCase {
    private let firebaseAuthRepository: FirebaseAuthRepository

    init(firebaseAuthRepository: FirebaseAuthRepository) {
        self.firebaseAuthRepository = firebaseAuthRepository
    }

    func execute(email: String, password: String, completion: @escaping (Error?) -> Void) {
        firebaseAuthRepository.signIn(email: email, password: password, completion: completion)
    }
}
