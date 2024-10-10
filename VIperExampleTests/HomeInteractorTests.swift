//
//  HomeInteractorTests.swift
//  VIperExampleTests
//
//  Created by Diego on 9/10/24.
//

import XCTest

@testable import VIperExample

final class HomeInteractorTests: XCTestCase {
    
    var interactor: HomePresenterToInteractorProtocol!
    var repository: HomeRepositoryProtocol!
    var apiClient: ApiClientMock!
    
    var presenter: MockPresenter!
    
    override func setUp() {
        
        apiClient = ApiClientMock()
        repository = HomeRepositoryImplementation(apiClient: apiClient)
        interactor = HomeInteractor(repository: repository)
        
        presenter = MockPresenter()
        interactor.presenter = presenter
    }
    
    override func tearDown() {
        apiClient = nil
        repository = nil
        interactor = nil
    }
    
    func test_loadServiceSuccess() {
        presenter.expectation = expectation(description: "Cargar listado de ofertas")
        
        apiClient.responseMockApiClient = .success
        interactor.loadService()
        
        wait(for: [presenter.expectation!], timeout: 1.0)
        
        XCTAssertNotNil(presenter.list, "La lista no debería ser nula")
    }
    
    func test_loadServiceError() {
        presenter.expectation = expectation(description: "Error al cargar listado de ofertas")
        
        apiClient.responseMockApiClient = .failure
        interactor.loadService()
        
        wait(for: [presenter.expectation!], timeout: 1.0)
        
        let error : NetworkError = .noData
        
        XCTAssertEqual(presenter.error, error)
    }
}


class MockPresenter: HomeInteractorToPresenterProtocol {
    
    var expectation: XCTestExpectation?
    var list: OffersEntity?
    var error: NetworkError?
    
    func success(list: OffersEntity) {
        self.list = list
        expectation?.fulfill()
    }
    
    func failure(error: NetworkError) {
        self.error = error
        expectation?.fulfill()
    }
}
