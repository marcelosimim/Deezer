//
//  MusicModelBuilder.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

final class MusicModelBuilder {
    private var musicModel = MusicModel()

    func withId(id: Int?) -> MusicModelBuilder {
        musicModel.id = id
        return self
    }

    func withTitle(title: String?) -> MusicModelBuilder {
        musicModel.title = title
        return self
    }

    func withPreview(preview: String?) -> MusicModelBuilder {
        musicModel.preview = preview
        return self
    }

    func withPosition(position: Int?) -> MusicModelBuilder {
        musicModel.position = position
        return self
    }

    func withArtist(artist: ArtistModel?) -> MusicModelBuilder {
        musicModel.artist = artist
        return self
    }

    func withAlbum(album: AlbumModel?) -> MusicModelBuilder {
        musicModel.album = album
        return self
    }

    func build() -> MusicModel {
        musicModel
    }
}
