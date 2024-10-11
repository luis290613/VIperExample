//
//  HomeViewController.swift
//  VIperExample
//
//  Created by Diego on 8/10/24.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    var presenter: HomeViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        presenter?.viewDidLoad()
    }
}

extension HomeViewController : HomePresenterToViewProtocol {
    
    func showLoader() {
        title = "Show Loader"
    }
    
    func hideLoader() {
        title = "Hide Loader"
        view.backgroundColor = .green
    }
    
    func printList(list: OffersEntity) {
        list.offers.forEach { offer in
            print("Oferta: \(offer.title)")
        }
    }
    
    func showAlert(error: NetworkError) {
        print("showAlert : \(error)")
    }
}
