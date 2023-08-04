//
//  NetworkManager.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 04/08/23.
//

import Foundation

class NetworkManager: ObservableObject {

    @Published var allMovies: [Movie] = []

    func fetchData(page: Int) {
        let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZGIwMmZjNzUyNDc1MjhlYjlkMmU0Y2NjN2RhNTkzZCIsInN1YiI6IjY0MmIyNzc1YmYzMWYyMDBmMmU5YmMxOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.w_GJ_OURigsQuMKhxVSIhZJnUzpk37oxbVbnDwKr7i4"
        let urlString = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=pt-BR&page=\(page)&sort_by=popularity.desc"
        guard let url = URL(string: urlString) else {
            print("url invalida")
            return
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, error, response in

            guard let data = data else {
                print("Erro ao obter dados")
                return
            }

            do {
                let decodeResponse = try JSONDecoder().decode(MovieModel.self, from: data)
                print("deu bom \(decodeResponse)")
                DispatchQueue.main.async {
                    self.allMovies.append(contentsOf: decodeResponse.results)
                }

            } catch {
                print("Error ao decodar \(error.localizedDescription)")
            }


        }.resume()
    }
}
