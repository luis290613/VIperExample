//
//  HomeInteractor.swift
//  VIperExample
//
//  Created by Diego on 8/10/24.
//

import Foundation

class HomeInteractor {
    weak var presenter: HomeInteractorToPresenterProtocol?
    var repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepositoryImplementation(apiClient: APIClient())) {
        self.repository = repository
    }
}

extension HomeInteractor : HomePresenterToInteractorProtocol {
    
    func loadService() {
        repository.getListOfferts { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let list):
                presenter?.success(list: list)
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
