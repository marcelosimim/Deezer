//
//  DefaultFirebaseAuthRepository.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

final class DefaultFirebaseAuthRepository: FirebaseAuthRepository {

    lazy var userRef = Firestore.firestore().collection("Users")

    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { authDataResult, error in
            guard let _ = authDataResult else {
                completion(error)
                return
            }
            completion(nil)
        })
    }

    func register(user: UserModel, email: String, password: String, completion: @escaping (Error?) -> Void) {
        let newUser = UserEntity.fromModel(user: user)

        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            guard let error = error else {
                self.userRef.document(Auth.auth().currentUser?.uid ?? "")
                    .setData([
                        "email": email,
                        "name": newUser.fullName,
                    ])
                completion(nil)
                return
            }
            completion(error)
        }
    }

    func logout(completion: @escaping((Error?) -> Void)) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch (let error) {
            completion(error)
        }

    }

    func recoverPassword(email: String, completion: @escaping((Error?) -> Void)) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
}
