//
//  RegisterUseCase.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

protocol RegisterUseCase {
    func execute(user: UserModel, email: String, password: String, completion: @escaping(Error?) -> Void)
}
