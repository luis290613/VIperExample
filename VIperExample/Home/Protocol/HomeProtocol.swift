//
//  HomeProtocol.swift
//  VIperExample
//
//  Created by Diego on 8/10/24.
//

import UIKit

// MARK: Presenter -> View
protocol HomePresenterToViewProtocol : AnyObject {
    var presenter: HomeViewToPresenterProtocol? { get set }
    func showLoader()
    func hideLoader()
    func printList(list: OffersEntity)
}


typealias HomePresenterProtocol = HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol

// MARK: View -> Presenter
protocol HomeViewToPresenterProtocol : AnyObject {
    var view: HomePresenterToViewProtocol? { get set }
    var interactor : HomePresenterToInteractorProtocol? { get set }
    var router: HomePresenterToRouterProtocol? { get set }
    func viewDidLoad()
}
// MARK: Interactor -> Presenter
protocol HomeInteractorToPresenterProtocol : AnyObject {
    func success(list: OffersEntity)
    func failure()
}


// MARK: Presenter -> Interactor
protocol HomePresenterToInteractorProtocol : AnyObject {
    var presenter: HomeInteractorToPresenterProtocol? { get set }
    func loadService()
}

// MARK: Presenter -> Router
protocol HomePresenterToRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func showNextView()
}
