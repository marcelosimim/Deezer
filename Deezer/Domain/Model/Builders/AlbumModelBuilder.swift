//
//  AlbumModelBuilder.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

final class AlbumModelBuilder {
    private var albumModel = AlbumModel()

    func withId(id: Int?) -> AlbumModelBuilder {
        albumModel.id = id
        return self
    }

    func withTitle(title: String?) -> AlbumModelBuilder {
        albumModel.title = title
        return self
    }

    func withCoverBig(coverBig: String?) -> AlbumModelBuilder {
        albumModel.cover_big = coverBig
        return self
    }

    func build() -> AlbumModel {
        albumModel
    }
}
