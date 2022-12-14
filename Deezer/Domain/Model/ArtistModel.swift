//
//  ArtistModel.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

struct ArtistsModel: Decodable {
    var data: [ArtistModel]?
}

struct ArtistModel: Decodable {
    var id: Int?
    var name: String?
    var picture_big: String?
}
