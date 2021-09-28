import Foundation
import XCTest

@testable import Common

private struct Constants {
  static let message = "It's broke ¯_(ツ)_¯"
  static let serverErrorTitle = "server_error:"
  static let parsingErrorTitle = "parsing_error:"
}

class APIErrorTests: XCTestCase {

  private let serverError: APIError = .server(Constants.message)
  private let parsingError: APIError = .parsing(Constants.message)

  func test_ServerError_HasCorrectTitle() throws {
    XCTAssertEqual(serverError.title, Constants.serverErrorTitle)
  }

  func test_ServerError_HasCorrectMessage() throws {
    XCTAssertEqual(serverError.message, Constants.message)
  }

  func test_ParsingError_HasCorrectTitle() throws {
    XCTAssertEqual(parsingError.title, Constants.parsingErrorTitle)
  }

  func test_ParsingError_HasCorrectMessage() throws {
    XCTAssertEqual(parsingError.message, Constants.message)
  }
}
