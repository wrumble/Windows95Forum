import Foundation
import XCTest

@testable import Common

private struct Constants {
  static let message = "It's broke ¯_(ツ)_¯"
  static let serverErrorTitle = "Server error:"
  static let parsingErrorTitle = "Parsing error:"
}

class APIErrorTests: XCTestCase {

  func test_ServerError_HasCorrectTitle() throws {
    XCTAssertEqual(APIError.server.title, Constants.serverErrorTitle)
  }

  func test_ServerError_HasCorrectMessage() throws {
    let serverError: APIError = .server(Constants.message)

    XCTAssertEqual(serverError.message, Constants.message)
  }

  func test_ParsingError_HasCorrectTitle() throws {
    XCTAssertEqual(APIError.parsing.title, Constants.parsingErrorTitle)
  }

  func test_ParsingError_HasCorrectMessage() throws {
    let parsingError: APIError = .parsing(Constants.message)

    XCTAssertEqual(parsingError.message, Constants.message)
  }
}
