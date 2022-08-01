//
//  DefaultHomeUseCase.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

class DefaultHomeUseCase: HomeUseCase {
    private let deezerAPIRepository: DeezerAPIRepository

    init(deezerAPIRepository: DeezerAPIRepository) {
        self.deezerAPIRepository = deezerAPIRepository
    }

    func getCharts(completion: @escaping (ChartsModel) -> Void) {
        deezerAPIRepository.getCharts(completion: completion)
    }

    func searchArtist(search: String, completion: @escaping(ArtistsModel) -> Void) {
        deezerAPIRepository.searchArtist(search: search, completion: completion)
    }

    func searchMusic(search: String, completion: @escaping(ChartsModel) -> Void) {
        deezerAPIRepository.searchMusic(search: search, completion: completion)
    }
}
