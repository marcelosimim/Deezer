//
//  DefaultFirebaseFirestoreRepository.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 8/1/22.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

final class DefaultFirebaseFirestoreRepository: FirebaseFirestoreRepository {
    lazy var userRef = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "")

    func getUserData(completion: @escaping ((Result<UserModel?, Error>) -> Void)) {
        var user = UserEntity()

        userRef.getDocument { document, error in
            guard let document = document?.data() else {
                completion(.failure(error!))
                return
            }

            user.fullName = document["name"] as? String
            user.email = document["email"] as? String
            completion(.success(user.toModel()))
        }
    }
}
