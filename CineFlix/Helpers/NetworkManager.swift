//
//  NetworkManager.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 04/08/23.
//

import Foundation
import Alamofire
import SwiftUI

enum APIConstants {
    static let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZGIwMmZjNzUyNDc1MjhlYjlkMmU0Y2NjN2RhNTkzZCIsInN1YiI6IjY0MmIyNzc1YmYzMWYyMDBmMmU5YmMxOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.w_GJ_OURigsQuMKhxVSIhZJnUzpk37oxbVbnDwKr7i4"

    static let baseUrlV3 = "https://api.themoviedb.org/3"

    static let baseUrlV4 = "https://api.themoviedb.org/4"

}

class NetworkManager {

    func fetchRequestToken(completion: @escaping (RequestTokenResponse) -> Void) {
        let endpoint = "/auth/request_token"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(APIConstants.apiKey)",
            "Content-type": "application/json"
        ]

        let bodyParameters: [String: String] = [
            "redirect_to": "cineflix://authentication"
        ]

        AF.request(APIConstants.baseUrlV4 + endpoint,
                   method: .post,
                   parameters: bodyParameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: RequestTokenResponse.self) { response in
            switch response.result {
            case .success(let requestTokenResponse):
                completion(requestTokenResponse)
            case .failure(let error):
                print(error)

            }
        }

    }

    func fetchAccessToken(requestToken: String, completion: @escaping (AccessTokenResponse) -> Void) {
        let endpoint = "/auth/access_token"

        let accessTokenRequest = AccessTokenRequest(requestToken: requestToken)

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(APIConstants.apiKey)",
            "Content-type": "application/json"
        ]

        AF.request(APIConstants.baseUrlV4 + endpoint,
                   method: .post,
                   parameters: accessTokenRequest,
                   encoder: JSONParameterEncoder.default,
                   headers: headers) { request in
            request.httpBody = try? JSONEncoder().encode(accessTokenRequest)
        }
                   .validate()
                   .responseDecodable(of: AccessTokenResponse.self) { [weak self] response in
                       guard let self = self else { return }
                       switch response.result {
                       case .success(let accessTokenResponse):
                           print("\(accessTokenResponse)")
                           completion(accessTokenResponse)
                           self.fetchSessionIdV3(accessToken: accessTokenResponse.accessToken)
                       case .failure(let error):
                           print(error)
                       }
                   }
    }

    func fetchSessionIdV3(accessToken: String) {
        let endpoint = "/authentication/session/convert/4"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(APIConstants.apiKey)",
            "Content-type": "application/json"
        ]

        let bodyParameters: [String: String] = [
            "access_token": accessToken
        ]

        AF.request(APIConstants.baseUrlV3 + endpoint,
                   method: .post,
                   parameters: bodyParameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers
        )
        .validate()
        .responseDecodable(of: SessionIdResponse.self) { response in
            switch response.result {
            case .success(let sessionIdResponse):
                print("\(sessionIdResponse.success)")
            case .failure(let error):
                print("\(error)")
            }
        }
    }

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

        AF.request(APIConstants.baseUrlV3 + endpoint, parameters: parameters, headers: HTTPHeaders(["Authorization": "Bearer \(APIConstants.apiKey)"]))
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

    func fetchSearchResults(query: String, page: Int, completion: @escaping (SearchCollection) -> ()) {
        let endpoint = "/search/movie"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(APIConstants.apiKey)",
            "Content-type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "query": query,
            "include_adult": true,
            "language": "pt-BR",
            "page": page
        ]

        AF.request(APIConstants.baseUrlV3 + endpoint, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: SearchCollection.self,
                               decoder: JSONDecoder.default) { response in
                switch response.result {
                case .success(let searchBarResponse):
                    completion(searchBarResponse)
                case .failure(let error):
                    print("\(error)")
                }
            }
    }

    func fetchMovieDetails(_ movieId: Int, completion: @escaping (MovieDetailsResponse) -> ()) {
        let endpoint = "/movie/\(movieId)"
        print("\(movieId)")

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(APIConstants.apiKey)",
            "Content-type": "application/json"
        ]

        let parameters: [String: Any] = [
            "language": "pt-BR",
        ]

        AF.request(APIConstants.baseUrlV3 + endpoint, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: MovieDetailsResponse.self) { response in
                switch response.result {
                case .success(let movieDetailsResponse):
                    completion(movieDetailsResponse)
                case.failure(let error):
                    print("\(error)")
                }
            }
    }

}

