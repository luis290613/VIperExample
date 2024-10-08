//
//  HomeRouter.swift
//  VIperExample
//
//  Created by Diego on 8/10/24.
//

import UIKit

class HomeRouter {
    var viewController: UIViewController?
}

extension HomeRouter : HomePresenterToRouterProtocol {
    
    func showNextView() {
        // Next VC
    }
    
    static func createModule() -> UIViewController {
        
        let ViewController : HomePresenterToViewProtocol = HomeViewController()
        let presenter : HomePresenterProtocol = HomePresenter()
        let interactor : HomePresenterToInteractorProtocol = HomeInteractor()
        let router: HomePresenterToRouterProtocol = HomeRouter()
        
        
        ViewController.presenter = presenter
        presenter.view = ViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        guard let vc = ViewController as? UIViewController else {
            return UIViewController()
        }
        router.viewController = vc
        
        return vc
    }
}
