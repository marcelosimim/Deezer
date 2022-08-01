//
//  Charts.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

struct Charts {
    var data:[Music]?
    var total:Int?

    static func fromChartsModel(charts: ChartsModel) -> Charts {
        var musics:[Music] = []
        guard let data = charts.data else {
            return Charts()
        }

        for music in data {
            musics.append(Music.fromMusicModel(music: music))
        }
        return Charts(data: musics, total: charts.total)
    }
}
