//
//  DI.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import Foundation
import Swinject

class AppContainer {
    public static let shared: Container = {
        let container = Container()

        container.register(FirebaseAuthRepository.self) { _ in DefaultFirebaseAuthRepository()}
        container.register(RegisterUseCase.self) { r in DefaultRegisterUseCase(firebaseAuthRepository: r.resolve(FirebaseAuthRepository.self)!)}
        container.register(RegisterViewModel.self) { r in DefaultRegisterViewModel(registerUseCase: r.resolve(RegisterUseCase.self)!)}

        return container
    }()
}
