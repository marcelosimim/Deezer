//
//  MusicModel.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

struct ChartsModel: Decodable {
    var data:[MusicModel]?
    var total:Int?
}

struct MusicModel: Decodable {
    var id: Int?
    var title: String?
    var preview: String?
    var position: Int?
    var artist: ArtistModel?
    var album: AlbumModel?
}

