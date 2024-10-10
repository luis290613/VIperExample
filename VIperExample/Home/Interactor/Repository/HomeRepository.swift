//
//  HomeRepository.swift
//  VIperExample
//
//  Created by Diego on 8/10/24.
//

// MARK: - Importante
/*
 La capa Interactor y esta capa(Repository) de momento hace lo mismo, pero esta capa esta enfocada en manejar las fuentes de datos:
 - Un ejemplo claro sería si queremos recuperar datos de cache cuando nos retorne un error el ApiClient
 - Hacer peticiones a UserDefault, CoreData, Keychang etc.
 */


import Foundation

// MARK: - Repository
protocol HomeRepositoryProtocol {
    func getListOfferts(completion: @escaping (Result<OffersEntity,NetworkError>) -> Void )
}


// MARK: - Repository implementation
class HomeRepositoryImplementation: HomeRepositoryProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getListOfferts(completion: @escaping (Result<OffersEntity, NetworkError>) -> Void) {
        
        
        // Si solo se maneja llamada https entonces se puede manejar así
        /* 
         apiClient.request(endpoint: .listOffers) { (result: Result<OffersEntity, NetworkError>) in
         completion(result)
        }
        */
        
        apiClient.request(endpoint: .listOffers) { (result: Result<OffersEntity, NetworkError>) in
            
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
