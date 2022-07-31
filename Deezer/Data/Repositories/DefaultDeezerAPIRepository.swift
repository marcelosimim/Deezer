//
//  DefaultDeezerAPIRepository.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import Foundation

class DefaultDeezerAPIRepository: DeezerAPIRepository {
    let baseURL = "https://api.deezer.com/"

    func getCharts(completion: @escaping (ChartsModel) -> Void) {
        guard let sourceURL = URL(string: "\(baseURL)/chart/0/tracks") else {
            return
        }

        URLSession.shared.dataTask(with: sourceURL) {(data, URLResponse, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(ChartsModel.self, from: data)
                    print("results", results)
                    completion(results)
                }
                catch {
                    print("error", error)
                    return
                }
            }
        }.resume()
    }
}
