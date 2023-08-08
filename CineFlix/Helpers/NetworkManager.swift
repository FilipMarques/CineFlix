//
//  NetworkManager.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 04/08/23.
//

import Foundation
import Alamofire

class NetworkManager: ObservableObject {

    func fetchData(page: Int, completion: @escaping ([Movie]) -> Void) {
           let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZGIwMmZjNzUyNDc1MjhlYjlkMmU0Y2NjN2RhNTkzZCIsInN1YiI6IjY0MmIyNzc1YmYzMWYyMDBmMmU5YmMxOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.w_GJ_OURigsQuMKhxVSIhZJnUzpk37oxbVbnDwKr7i4"
           let urlString = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=pt-BR&page=\(page)&sort_by=popularity.desc"

           AF.request(urlString, headers: HTTPHeaders(["Authorization": "Bearer \(apiKey)"]))
               .validate()
               .responseDecodable(of: MovieModel.self) { response in
                   print("\(String(describing: response.response?.statusCode))")
                   switch response.result {
                   case .success(let movieModel):
                       print("deu bom \(movieModel)")
                       completion(movieModel.results)
                   case .failure(let error):
                       print("Erro ao decodar \(error.localizedDescription)")
                   }
               }
       }
}
