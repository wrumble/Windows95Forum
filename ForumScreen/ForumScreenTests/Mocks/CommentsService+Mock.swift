import Combine

import Common
import CommentsService

class CommentsServiceMock: CommentsServiceProtocol {

  var comments: [Comment] = [.mock(), .mock()]

  var getCommentsCallCount = 0

  func getComments(postId: Int) -> AnyPublisher<[Comment], APIError> {

    getCommentsCallCount += 1

    return Just(comments)
      .setFailureType(to: APIError.self)
      .eraseToAnyPublisher()
  }

  func reset() {
    getCommentsCallCount = 0
  }
}
