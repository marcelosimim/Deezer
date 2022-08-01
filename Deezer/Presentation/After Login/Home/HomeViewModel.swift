//
//  HomeViewModel.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

protocol HomeViewModel {
    var charts: Observable<Charts?> { get }
    var showsCharts: Observable<Bool> { get }
    var artists: Observable<Artists?> { get }
    var showsArtists: Observable<Bool> { get }
    var isSingerButtonChecked: Observable<Bool> { get }
    var isMusicButtonChecked: Observable<Bool> { get }

    func getCharts()
    func textFieldDidChange(_ text: String)
    func singerTapped()
    func musicTapped()
}

class DefaultHomeViewModel: HomeViewModel {
    private let homeUseCase: HomeUseCase
    var charts = Observable<Charts?>(nil)
    var showsCharts = Observable<Bool>(true)
    var artists = Observable<Artists?>(nil)
    var showsArtists = Observable<Bool>(false)
    var isSingerButtonChecked = Observable<Bool>(true)
    var isMusicButtonChecked = Observable<Bool>(false)

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }

    func getCharts() {
        homeUseCase.getCharts { musics in
            self.charts.value = Charts.fromChartsModel(charts: musics)
            self.showsCharts.value = true
            self.showsArtists.value = false
        }
    }

    func textFieldDidChange(_ text: String) {
        if text.isEmpty {
            getCharts()
        } else {
            searchArtist(search: text)
        }
    }

    func singerTapped() {
        isSingerButtonChecked.value.toggle()
    }

    func musicTapped() {
        isMusicButtonChecked.value.toggle()
    }

    private func searchArtist(search: String) {
        homeUseCase.searchArtist(search: search) { artists in
            self.artists.value = Artists.fromArtistsModel(artistsModel: artists)
            self.showsCharts.value = false
            self.showsArtists.value = true
        }
    }
}
