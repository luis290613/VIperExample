//
//  APIClientMock.swift
//  VIperExample
//
//  Created by Diego on 9/10/24.
//

import Foundation

enum ResponseMockApiClient {
    case success
    case failure
}

class ApiClientMock: APIClientProtocol {
    
    var responseMockApiClient : ResponseMockApiClient = .success
    
    func request<T: Decodable>(endpoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        switch responseMockApiClient {
        case .success:
            switch endpoint {
            case .listOffers:
                let response = JSONLoader.obtainResponseObjectFromJsonFile(pathResource: "listOffers", type: T.self)
                completion(.success(response))
            }
        case .failure:
            completion(.failure(.noData))
            break
        }
    }
}
