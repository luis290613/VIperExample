//
//  HomeInteractor.swift
//  VIperExample
//
//  Created by Diego on 8/10/24.
//

import Foundation

class HomeInteractor {
    weak var presenter: HomeInteractorToPresenterProtocol?
    
}

extension HomeInteractor : HomePresenterToInteractorProtocol {
    
    func loadService() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: { [weak self] in
            guard let self else { return }
            
            presenter?.success()
        })
    }
}
