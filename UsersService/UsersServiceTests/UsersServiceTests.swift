import XCTest

import ForumClient

@testable import UsersService

private struct Constants {
  static let executeCallCount = 1
}

class UsersServiceTests: XCTestCase {

  private let clientMock = ForumClientMock()

  override func setUp() {
    let service = UsersService(client: clientMock)

    _ = service.getUsers()
  }

  override func tearDown() {
    clientMock.reset()
  }

  func test_UsersService_CallsClientExecute_Once() throws {
    XCTAssertEqual(clientMock.executeCallCount, Constants.executeCallCount)
  }

  func test_UserService_CallsClientExecute_WithPostsEndpoint() throws {
    XCTAssertEqual(clientMock.executeEndpointCalled, Endpoint.users)
  }
}
