//
//  Music.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

struct Music {
    var id: Int?
    var title: String?
    var preview: String?
    var position: Int?
    var artist: Artist?
    var album: Album?

    static func fromMusicModel(music: MusicModel) -> Music {
        Music(id: music.id, title: music.title, preview: music.preview, position: music.position, artist: Artist.fromArtistModel(artist: music.artist ?? ArtistModel()), album: Album.fromAlbumModel(album: music.album ?? AlbumModel()))
    }
}
