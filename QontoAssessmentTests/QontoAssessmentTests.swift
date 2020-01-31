//
//  QontoAssessmentTests.swift
//  QontoAssessmentTests
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import XCTest
@testable import QontoAssessment

class QontoAssessmentTests: XCTestCase {
    
    var mainInteractor: MainInteractor!
    let timeout = 1.0

    override func setUp() {
        mainInteractor = MainInteractor()
    }

    override func tearDown() {
        mainInteractor = nil
    }

    func testCallbackUpdate() {
        let expectation = XCTestExpectation(description: "default user list is nil")
        
        mainInteractor.callbackModelUpdate = { (viewModel) in
            XCTAssertNil(viewModel.userList)
            expectation.fulfill()
        }
        mainInteractor.onViewDidLoad()
        
        wait(for: [expectation], timeout: timeout)
    }

}
