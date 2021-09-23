import Foundation
import XCTest

@testable import ForumClient

private struct Constants {
  static let message = "It's broke ¯_(ツ)_¯"
  static let serverError = "Server error: \(message)"
  static let parsingError = "Parsing error: \(message)"
}

class APIErrorTests: XCTestCase {

  func test_ServerError_HasCorrectMessage() throws {
    let serverError: APIError = .server(Constants.message)

    XCTAssertEqual(serverError.message, Constants.serverError)
  }

  func test_ParsingError_HasCorrectMessage() throws {
    let parsingError: APIError = .parsing(Constants.message)

    XCTAssertEqual(parsingError.message, Constants.parsingError)
  }
}
