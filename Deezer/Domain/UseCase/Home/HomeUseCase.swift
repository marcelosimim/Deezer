//
//  HomeUseCase.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

protocol HomeUseCase {
    func getCharts(completion: @escaping(ChartsModel) -> Void)
    func searchArtist(search: String, completion: @escaping(ArtistsModel) -> Void)
    func searchMusic(search: String, completion: @escaping(ChartsModel) -> Void)
}
