//
//  HomePresenterTests.swift
//  VIperExampleTests
//
//  Created by Diego on 10/10/24.
//

import XCTest

@testable import VIperExample

final class HomePresenterTests: XCTestCase {
    
    var viewController: MockHomeViewController!
    var interactor : MockHomeInteractor!
    var router: HomePresenterToRouterProtocol!
    
    var presenter: HomePresenterProtocol!
    
    
    
    override func setUp() {
        viewController = MockHomeViewController()
        
        interactor = MockHomeInteractor()
        
        router = MockHomeRouter()
        
        presenter = HomePresenter()
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
    
    override func tearDown() {
        viewController = nil
        interactor = nil
        presenter = nil
        router = nil
    }
    
    
    func test_viewDidLoad() {
        presenter.viewDidLoad()
        
        XCTAssertTrue(viewController.showLoaderBool)
        XCTAssertTrue(interactor.loadServiceBool)
    }
    
    func test_success() {
        let expectation = self.expectation(description: "Wait for hideLoader and list to be set")

        presenter.success(list: OffersEntity(title: "title", offers: []))
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.viewController.hideLoaderBool)
            XCTAssertNotNil(self.viewController.list)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_failure() {
        let expectation = self.expectation(description: "Wait for hideLoader and failure response")
        
        presenter.failure(error: .noData)
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.viewController.hideLoaderBool)
            XCTAssertNotNil(self.viewController.error)
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
}

class MockHomeViewController: HomePresenterToViewProtocol {
    var presenter: HomeViewToPresenterProtocol?
    
    var showLoaderBool = false
    var hideLoaderBool = false
    var list: OffersEntity?
    var error: NetworkError?
    
    
    func showLoader() {
        showLoaderBool = true
    }
    
    func hideLoader() {
        hideLoaderBool = true
    }
    
    func printList(list: OffersEntity) {
        self.list = list
    }
    
    func showAlert(error: NetworkError) {
        self.error = error
    }
    
}

class MockHomeRouter: HomePresenterToRouterProtocol {
    var viewController: UIViewController?
    
    func showNextView() {
        
    }
}

class MockHomeInteractor: HomePresenterToInteractorProtocol {
    var presenter: HomeInteractorToPresenterProtocol?
    
    var loadServiceBool = false
    
    func loadService() {
        loadServiceBool = true
    }
     
}
