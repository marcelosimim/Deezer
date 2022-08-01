//
//  UserModelBuilder.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import Foundation

final class UserModelBuilder {

    private var userModel = UserModel()

    func withFullName(fullName: String?) -> UserModelBuilder {
        userModel.fullName = fullName
        return self
    }

    func withPerfilImage(perfilImage: Data?) -> UserModelBuilder {
        userModel.perfilImage = perfilImage
        return self
    }

    func withEmail(email: String?) -> UserModelBuilder {
        userModel.email = email
        return self
    }

    func build() -> UserModel {
        userModel
    }
}
