//
//  HomePresenter.swift
//  VIperExample
//
//  Created by Diego on 8/10/24.
//

import Foundation

class HomePresenter {
    weak var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
}

extension HomePresenter : HomeViewToPresenterProtocol {
    func viewDidLoad() {
        view?.showLoader()
        interactor?.loadService()
    }
}

extension HomePresenter : HomeInteractorToPresenterProtocol {
    func success(list: OffersEntity) {
        DispatchQueue.main.async {
            self.view?.hideLoader()
            self.view?.printList(list: list)
        }
    }
    
    func failure(error: NetworkError) {
        view?.hideLoader()
    }
}
