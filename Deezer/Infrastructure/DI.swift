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
        container.register(DeezerAPIRepository.self) { _ in DefaultDeezerAPIRepository()}
        container.register(RegisterUseCase.self) { r in DefaultRegisterUseCase(firebaseAuthRepository: r.resolve(FirebaseAuthRepository.self)!)}
        container.register(RegisterViewModel.self) { r in DefaultRegisterViewModel(registerUseCase: r.resolve(RegisterUseCase.self)!)}
        container.register(LoginUseCase.self) { r in DefaultLoginUseCase(firebaseAuthRepository: r.resolve(FirebaseAuthRepository.self)!)}
        container.register(LoginViewModel.self) { r in DefaultLoginViewModel(loginUseCase: r.resolve(LoginUseCase.self)!)}
        container.register(HomeUseCase.self) { r in DefaultHomeUseCase(deezerAPIRepository: r.resolve(DeezerAPIRepository.self)!)}
        container.register(HomeViewModel.self) { r in DefaultHomeViewModel(homeUseCase: r.resolve(HomeUseCase.self)!)}
        return container
    }()
}
