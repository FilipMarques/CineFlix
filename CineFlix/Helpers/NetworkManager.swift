//
//  NetworkManager.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 04/08/23.
//

import Foundation
import Alamofire

enum APIConstants {
    static let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZGIwMmZjNzUyNDc1MjhlYjlkMmU0Y2NjN2RhNTkzZCIsInN1YiI6IjY0MmIyNzc1YmYzMWYyMDBmMmU5YmMxOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.w_GJ_OURigsQuMKhxVSIhZJnUzpk37oxbVbnDwKr7i4"

    static let baseUrl = "https://api.themoviedb.org/3"

}

class NetworkManager {

    func fetchData(page: Int, completion: @escaping ([Movie]) -> Void) {
        let endpoint = "/discover/movie"
        let parameters: [String: Any] = [
            "include_adult": false,
            "include_video": false,
            "language": "pt-BR",
            "page": page,
            "sort_by": "popularity.desc",
            "api_key": APIConstants.apiKey
        ]

        AF.request(APIConstants.baseUrl + endpoint, parameters: parameters, headers: HTTPHeaders(["Authorization": "Bearer \(APIConstants.apiKey)"]))
            .validate()
            .responseDecodable(of: PageList<Movie>.self) { response in
                switch response.result {
                case .success(let moviesResponse):
                    completion(moviesResponse.results)
                case .failure(let error):
                    print("Erro ao decodar \(error.localizedDescription)")
                }
            }
    }
}

