import XCTest

@testable import ForumScreen

private struct Constants {
  static let id: Int = 1
  static let wrongId: Int = 2
  static let username = "username"
  static let title = "title"
}

class ForumPostFactoryTests: XCTestCase {

  func test_ReturnsAForumPost_WhenUsersAndPostsHaveMatchingIds() throws {
    let forumPost = ForumPostFactory.forumPosts(
      from: [.mock()],
      posts: [.mock()])
    let expectation = [ForumPost(
      id: Constants.id,
      username: Constants.username,
      title: Constants.title)]

    XCTAssertEqual(forumPost, expectation)
  }
  
  func test_ReturnsEmptyArray_WhenUsersAndPostsDontHaveAnyMatchingIds() throws {
    let forumPost = ForumPostFactory.forumPosts(
      from: [.mock(id: Constants.wrongId)],
      posts: [.mock()])
    let expectation = [ForumPost]()

    XCTAssertEqual(forumPost, expectation)
  }
}
