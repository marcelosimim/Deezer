//
//  User.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import Foundation

struct User {

    let fullName: String?
    let email: String?
    let perfilImage: Data?

    func toUserModel() -> UserModel {
        UserModelBuilder()
            .withFullName(fullName: fullName)
            .withEmail(email: email)
            .withPerfilImage(perfilImage: perfilImage)
            .build()
    }

    static func fromUserModel(user: UserModel) -> User {
        User(fullName: user.fullName, email: user.email, perfilImage: user.perfilImage)
    }
}
