//
//  Artist.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

struct Artists {
    var artists: [Artist]?

    static func fromArtistsModel(artistsModel: ArtistsModel) -> Artists {
        var artists:[Artist] = []
        guard let data = artistsModel.data else {
            return Artists()
        }

        for artist in data {
            artists.append(Artist.fromArtistModel(artist: artist))
        }
        return Artists(artists: artists)
    }
}

struct Artist {
    var id: Int?
    var name: String?
    var picture_big: String?

    static func fromArtistModel(artist: ArtistModel) -> Artist {
        Artist(id: artist.id, name: artist.name, picture_big: artist.picture_big)
    }
}
