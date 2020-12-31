//
//  CocoaTouchTests.swift
//  CocoaTouchTests
//
//  Created by Chris Barker on 04/12/2020.
//

import XCTest
@testable import CocoaTouch

class CocoaTouchTests: XCTestCase {
    
    var viewControllerUnderTest: ReposTableViewController?
    
    // MARK: Overrides
    
    override func setUp() {
        viewControllerUnderTest = ReposTableViewController()
    }
    
    override func tearDown() { }
    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }
    
    // MARK: Tests
    
    func testThatFetchRepoParsesSuccessfulData() {
        
        viewControllerUnderTest?.session = MockURLSession()
        
        var responseObject: FetchReposResult?
        
        // Call the function we want to Test
        let result = viewControllerUnderTest?.fetchRepos(forUsername: "", completionHandler: { (response) in
            responseObject = response
        }) as? MockURLSessionDataTask
        
        // This forces the completion handler with our Mock Data
        result?.completionHandler(mockData, nil, nil)
        
        switch responseObject {
        case .success(let repos):
            
            // Our test data had 3 repos, lets check that parsed okay
            XCTAssertEqual(repos.count, 9)
            
            // We know the first repo has a specific name... let's check that
            XCTAssertEqual(repos.first?.name, "aerogear-ios-oauth2")
        default:
            // Anything other than success - failure...
            XCTFail()
        }
                
    }
    
    func testThatRepoIsNotNil() {
        XCTAssertNotNil(viewControllerUnderTest?.repos)
    }
    
    func testThatTextInputValidatesWithSingleWhitespaces() {
        let result = viewControllerUnderTest?.isUserInputValid(withText: "multiple white spaces")
        XCTAssertFalse(result!)
    }
    
    var mockData: Data {
        if let path = Bundle.main.path(forResource: "mock_Data", ofType: "json"), let contents = FileManager.default.contents(atPath: path){
            return contents
        }
        return Data()
    }
    
}

class MockURLSession: URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(completionHandler: completionHandler, request: request)
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    
    var completionHandler: (Data?, URLResponse?, Error?) -> Void
    var request: URLRequest
    
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void, request: URLRequest) {
        self.completionHandler = completionHandler
        self.request = request
        super.init()
    }
    
    var calledResume = false
    
    override func resume() {
        calledResume = true
    }
    
}

