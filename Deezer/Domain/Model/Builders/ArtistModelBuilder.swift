//
//  ArtistModelBuilder.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

final class ArtistModelBuilder {
    private var artistModel = ArtistModel()

    func withId(id: Int?) -> ArtistModelBuilder {
        artistModel.id = id
        return self
    }

    func withName(name: String?) -> ArtistModelBuilder {
        artistModel.name = name
        return self
    }

    func withPictureBig(pictureBig: String?) -> ArtistModelBuilder {
        artistModel.picture_big = pictureBig
        return self
    }

    func build() -> ArtistModel {
        artistModel
    }
}
