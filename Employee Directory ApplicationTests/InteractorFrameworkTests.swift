//
//  InteractorFrameworkTests.swift
//  Employee Directory ApplicationTests
//

import Alamofire
import Foundation
@testable import Employee_Directory_Application

class FakeInteractor: URLRequestConvertible {
    let nullService = ""
    let nullEmail = ""
    func asURLRequest() throws -> URLRequest {
        let request = constructURLRequest()
        return request
    }
}

private extension FakeInteractor {
    func constructURLRequest() -> URLRequest {
        if let url = URL(string: Constants.apiUrl) {
            return URLRequest(url: url)
        }
        return URLRequest(url: URL.errorUrl())
    }
}

import XCTest
class InteractorTest: XCTestCase {
    var interactor = FakeInteractor()
    var expect: XCTestExpectation!
    
    override func setUp() {
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testProfileUserFromUserDefault() throws {
        var urlRequest: URLRequest?
        do {
            urlRequest = try interactor.asURLRequest()
        } catch {
            XCTAssertTrue(false, "url request creation failure")
        }
        XCTAssertTrue(urlRequest != nil, "request should not be nil even if the url is bad")
    }

}

