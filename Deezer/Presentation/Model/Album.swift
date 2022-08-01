//
//  Album.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

struct Album {
    var id: Int?
    var title: String?
    var cover_big: String?

    static func fromAlbumModel(album: AlbumModel) -> Album {
        Album(id: album.id, title: album.title, cover_big: album.cover_big)
    }
}
