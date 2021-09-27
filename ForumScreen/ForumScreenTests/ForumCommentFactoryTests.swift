import XCTest

@testable import ForumScreen

private struct Constants {
  static let id: Int = 1
  static let text = "text"
}

class ForumCommentFactoryTests: XCTestCase {

  func test_ReturnsAForumComment_WhenPassedAComment() throws {
    let forumComment = ForumCommentFactory.forumComments(from: [.mock()])
    let expectation = [ForumComment(id: Constants.id, text: Constants.text)]

    XCTAssertEqual(forumComment, expectation)
  }
}
