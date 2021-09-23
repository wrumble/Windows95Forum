import Foundation
import XCTest

@testable import WindowsNetwork

private struct Constants {
  static let postsPath = "posts"
  static let usersPath = "users"
  static let commentsPath = "posts/\(postId)/comments"
  static let postId = 1
}

class EnpointTests: XCTestCase {

  func test_PostsEnpoint_HasCorrectPath() throws {
    let postsEndpoint: Endpoint = .posts

    XCTAssertEqual(postsEndpoint.path, Constants.postsPath)
  }

  func test_UsersEnpoint_HasCorrectPath() throws {
    let usersEndpoint: Endpoint = .users

    XCTAssertEqual(usersEndpoint.path, Constants.usersPath)
  }

  func test_CommentsEnpoint_HasCorrectPath() throws {
    let commentsEnpoint: Endpoint = .comments(postId: Constants.postId)

    XCTAssertEqual(commentsEnpoint.path, Constants.commentsPath)
  }
}
