import XCTest

import ForumClient

@testable import PostsService

private struct Constants {
  static let executeCallCount = 1
}

class PostsServiceTests: XCTestCase {

  private let clientMock = ForumClientMock()

  override func setUp() {
    let service = PostsService(client: clientMock)

    _ = service.getPosts()
  }

  override func tearDown() {
    clientMock.reset()
  }

  func test_PostsService_CallsClientExecute_Once() throws {
    XCTAssertEqual(clientMock.executeCallCount, Constants.executeCallCount)
  }

  func test_PostsService_CallsClientExecute_WithPostsEndpoint() throws {
    XCTAssertEqual(clientMock.executeEndpointCalled, Endpoint.posts)
  }
}
