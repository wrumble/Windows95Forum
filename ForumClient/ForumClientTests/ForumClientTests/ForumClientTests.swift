import Foundation
import XCTest
import Combine

@testable import ForumClient

private struct Constants {
  static let initialPostData = [Post(userId: 1, id: 1, title: "title")]
}

class ForumClientTests: XCTestCase {

  private var publishers = [AnyCancellable]()

  private var client: ForumClient!

  func test_ExecuteSucceeds_WhenPassedCorrectData() throws {
    var result = Constants.initialPostData
    let expectation = self.expectation(description: "waiting for validation")

    try setUpURLSession()

    executePosts()
      .receive(on: RunLoop.main)
      .sink(
        receiveCompletion: { error in
          switch error {
          case .failure(let error):
            XCTFail("Should receive Posts. Error: \(error)")
          case .finished:
            break
          }
        },
        receiveValue: { responseData in
          result = responseData
          expectation.fulfill()
        })
      .store(in: &publishers)

    wait(for: [expectation], timeout: 1)

    XCTAssertEqual(result, [Post.mock()], "Response data expected to be \(expectation) but was \(result)")
  }

  func test_ExecuteFails_WhenPassedWrongData() throws {
    var wasReceiveCompletionHit = false
    let expectation = self.expectation(description: "waiting for completion")

    try setUpURLSession(setResponseToFail: true)

    executePosts()
      .receive(on: RunLoop.main)
      .sink(
        receiveCompletion: { _ in
          expectation.fulfill()
          wasReceiveCompletionHit = true
        },
        receiveValue: { value in
          XCTFail("Should hit receiveCompletion not receiveValue: \(value)")
        })
      .store(in: &publishers)

    wait(for: [expectation], timeout: 1)

    XCTAssertTrue(wasReceiveCompletionHit)
  }
}

// Mark: Private

private extension ForumClientTests {
  func executePosts() -> AnyPublisher<[Post], APIError>{
    return client.execute(.posts)
  }

  func setUpURLSession(setResponseToFail: Bool = false) throws {
    let session = URLSession.mock()
    client = ForumClient(session: session)

    var mockData: Data!

    if setResponseToFail {
      mockData = try JSONEncoder().encode(User.mock())
    } else {
      mockData = try JSONEncoder().encode([Post.mock()])
    }

    URLProtocolMock.requestHandler = { request in
      return (HTTPURLResponse(), mockData)
    }
  }
}
