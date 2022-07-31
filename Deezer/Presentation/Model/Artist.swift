//
//  Artist.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

struct Artist {
    var id: Int?
    var name: String?
    var picture_big: String?

    static func fromArtistModel(artist: ArtistModel) -> Artist {
        Artist(id: artist.id, name: artist.name, picture_big: artist.picture_big)
    }
}
