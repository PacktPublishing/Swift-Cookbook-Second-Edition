import XCTest
@testable import TaskModule

final class TaskModuleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TaskViewModel().title, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
