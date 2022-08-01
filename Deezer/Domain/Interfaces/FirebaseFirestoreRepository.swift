//
//  FirebaseFirestoreRepository.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 8/1/22.
//

protocol FirebaseFirestoreRepository {
    func getUserData(completion: @escaping((Result<UserModel?, Error>) -> Void))
}
