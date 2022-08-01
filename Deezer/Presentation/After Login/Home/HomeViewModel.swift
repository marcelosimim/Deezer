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
    var musics: Observable<Charts?> { get }
    var showsMusics: Observable<Bool> { get }
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
    var musics = Observable<Charts?>(nil)
    var showsMusics = Observable<Bool>(false)
    var isSingerButtonChecked = Observable<Bool>(true)
    var isMusicButtonChecked = Observable<Bool>(false)

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }

    func getCharts() {
        homeUseCase.getCharts { musics in
            self.charts.value = Charts.fromChartsModel(charts: musics)
            self.setShowsCharts()
        }
    }

    func textFieldDidChange(_ text: String) {
        if text.isEmpty {
            getCharts()
        } else {
            isSingerButtonChecked.value ? searchArtist(search: text) : searchMusic(search: text)
        }
    }

    func singerTapped() {
        isSingerButtonChecked.value = true
        isMusicButtonChecked.value = false
        setShowsArtists()
    }

    func musicTapped() {
        isMusicButtonChecked.value = true
        isSingerButtonChecked.value = false
        setShowsMusics()
    }

    private func searchArtist(search: String) {
        homeUseCase.searchArtist(search: search) { artists in
            self.artists.value = Artists.fromArtistsModel(artistsModel: artists)
            self.setShowsArtists()
        }
    }

    private func searchMusic(search: String) {
        homeUseCase.searchMusic(search: search, completion: { musics in
            self.musics.value = Charts.fromChartsModel(charts: musics)
            self.setShowsMusics()
        })
    }

    private func setShowsCharts() {
        self.showsCharts.value = true
        self.showsArtists.value = false
        self.showsMusics.value = false
    }

    private func setShowsArtists() {
        self.showsArtists.value = true
        self.showsCharts.value = false
        self.showsMusics.value = false
    }

    private func setShowsMusics() {
        self.showsMusics.value = true
        self.showsCharts.value = false
        self.showsArtists.value = false
    }
}
