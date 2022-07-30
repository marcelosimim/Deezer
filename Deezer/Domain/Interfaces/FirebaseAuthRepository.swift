//
//  FirebaseAuthRepository.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

protocol FirebaseAuthRepository {
    func signIn(email: String, password:String, completion: @escaping(Error?) -> Void)
    func register(user: UserModel, email: String, password: String, completion: @escaping(Error?) -> Void)
    func logout(completion: @escaping((Error?) -> Void))
    func recoverPassword(email: String, completion: @escaping((Error?) -> Void))
}
