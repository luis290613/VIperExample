//
//  ApiClient.swift
//  VIperExample
//
//  Created by Diego on 8/10/24.
//

import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(endpoint: String, completion: @escaping (Result<T, NetworkError>) -> Void)

}

class APIClient: APIClientProtocol {
    func request<T: Decodable>(endpoint: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://z74vd.wiremockapi.cloud\(endpoint)") else {
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


//class APIClientMock: APIClientProtocol {
//    
//    var mockData: Data?
//    var mockError: Error?
//    
//    func request(endpoint: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
//        if let error = mockError {
//            completion(.failure(.serverError))
//        } else if let data = mockData {
//            completion(.success(data))
//        }
//    }
//}
