import XCTest

import ForumClient

@testable import CommentsService

private struct Constants {
  static let postId = 1
  static let executeCallCount = 1
}

class CommentsServiceTests: XCTestCase {

  private let clientMock = ForumClientMock()

  override func setUp() {
    let service = CommentsService(client: clientMock)

    _ = service.getComments(postId: Constants.postId)
  }

  override func tearDown() {
    clientMock.reset()
  }

  func test_CommentsService_CallsClientExecute_Once() throws {
    XCTAssertEqual(clientMock.executeCallCount, Constants.executeCallCount)
  }

  func test_CommentsService_CallsClientExecute_WithPostsEndpoint() throws {
    XCTAssertEqual(clientMock.executeEndpointCalled, Endpoint.comments(postId: Constants.postId))
  }
}
