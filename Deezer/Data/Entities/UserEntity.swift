//
//  UserEntity.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import Foundation

struct UserEntity {
    var fullName: String?
    var perfilImage: Data?
    var email: String?

    func toModel() -> UserModel {
        UserModelBuilder()
            .withFullName(fullName: fullName)
            .withPerfilImage(perfilImage: perfilImage)
            .withEmail(email: email)
            .build()
    }

    static func fromModel(user: UserModel) -> UserEntity {
        UserEntity(fullName: user.fullName, perfilImage: user.perfilImage, email: user.email)
    }
}
