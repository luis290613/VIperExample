//
//  ApiClient.swift
//  VIperExample
//
//  Created by Diego on 8/10/24.
//

import Foundation

enum EndPoint: String {
    case listOffers = "/offers/list"
}

protocol APIClientProtocol {
    func request<T: Decodable>(endpoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void)

}

class APIClient: APIClientProtocol {
    func request<T: Decodable>(endpoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://z74vd.wiremockapi.cloud\(endpoint.rawValue)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unknown))
            } 
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}


