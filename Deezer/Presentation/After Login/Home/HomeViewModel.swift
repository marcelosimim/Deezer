//
//  HomeViewModel.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

protocol HomeViewModel {
    var charts: Observable<Charts?> { get }

    func getCharts()
}

class DefaultHomeViewModel: HomeViewModel {
    private let homeUseCase: HomeUseCase
    var charts = Observable<Charts?>(nil)

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }

    func getCharts() {
        homeUseCase.getCharts { musics in
            self.charts.value = Charts.fromChartsModel(charts: musics)
        }
    }
}
