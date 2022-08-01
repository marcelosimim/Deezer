//
//  User.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import Foundation

struct User {
    var fullName: String?
    var email: String?
    var perfilImage: Data?

    init(fullName: String? = "", email: String? = "", perfilImage: Data? = nil) {
        self.fullName = fullName
        self.email = email
        self.perfilImage = perfilImage
    }

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
