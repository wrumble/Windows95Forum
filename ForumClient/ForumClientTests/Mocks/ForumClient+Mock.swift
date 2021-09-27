import Combine

import Common

public class ForumClientMock: ForumClientProtocol {

  public var executeCallCount = 0
  public var executeEndpointCalled: Endpoint?

  public init() { }

  public func execute<T: Codable>(_ endpoint: Endpoint) -> AnyPublisher<[T], APIError> {

    executeCallCount += 1
    executeEndpointCalled = endpoint

    return Just([])
      .setFailureType(to: APIError.self)
      .eraseToAnyPublisher()
  }

  public func reset() {
    executeCallCount = 0
    executeEndpointCalled = nil
  }
}
