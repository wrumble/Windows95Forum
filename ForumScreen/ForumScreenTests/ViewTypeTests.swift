import XCTest

@testable import ForumScreen

private struct Constants {
  static let postsTitle = "posts"
  static let commentsTitle = "comments"
  static let errorTitle = "error"
}

class ViewTypeTests: XCTestCase {

  func test_ReturnsCorrectTitle_WhenViewTypeIsPosts() throws {
    let viewType = ViewType.posts

    XCTAssertEqual(viewType.title, Constants.postsTitle)
  }

  func test_ReturnsCorrectTitle_WhenViewTypeIsComments() throws {
    let viewType = ViewType.comments

    XCTAssertEqual(viewType.title, Constants.commentsTitle)
  }

  func test_ReturnsCorrectTitle_WhenViewTypeIsError() throws {
    let viewType = ViewType.error

    XCTAssertEqual(viewType.title, Constants.errorTitle)
  }

  func test_ReturnsCorrectBoolean_ForShouldHideXButton_WhenViewTypeIsPosts() throws {
    let viewType = ViewType.posts

    XCTAssertTrue(viewType.shouldHideXButton)
  }

  func test_ReturnsCorrectBoolean_ForShouldHideXButton_WhenViewTypeIsComments() throws {
    let viewType = ViewType.comments

    XCTAssertFalse(viewType.shouldHideXButton)
  }

  func test_ReturnsCorrectBoolean_ForShouldHideXButton_WhenViewTypeIsError() throws {
    let viewType = ViewType.error

    XCTAssertFalse(viewType.shouldHideXButton)
  }
}
