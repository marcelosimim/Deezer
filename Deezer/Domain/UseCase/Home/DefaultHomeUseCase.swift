//
//  DefaultHomeUseCase.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

class DefaultHomeUseCase: HomeUseCase {
    private let deezerAPIRepository: DeezerAPIRepository
    private let firebaseFirestoreRepository: FirebaseFirestoreRepository

    init(deezerAPIRepository: DeezerAPIRepository, firebaseFirestoreRepository: FirebaseFirestoreRepository) {
        self.deezerAPIRepository = deezerAPIRepository
        self.firebaseFirestoreRepository = firebaseFirestoreRepository
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

    func getUserData(completion: @escaping ((Result<UserModel?, Error>) -> Void)) {
        firebaseFirestoreRepository.getUserData(completion: completion)
    }
}
