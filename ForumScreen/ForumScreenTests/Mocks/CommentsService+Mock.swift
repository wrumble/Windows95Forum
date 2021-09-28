import Combine

import Common
import CommentsService

class CommentsServiceMock: CommentsServiceProtocol {

  var comments: [Comment] = [.mock(), .mock()]
  var getCommentsCallCount = 0
  var error: APIError?

  func getComments(postId: Int) -> AnyPublisher<[Comment], APIError> {

    getCommentsCallCount += 1

    if error != nil {
      return Fail(error: error!)
        .eraseToAnyPublisher()
    } else {
      return Just(comments)
        .setFailureType(to: APIError.self)
        .eraseToAnyPublisher()
    }
  }

  func reset() {
    getCommentsCallCount = 0
    error = nil
  }
}
