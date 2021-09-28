import Combine

import Common
import PostsService

class PostsServiceMock: PostsServiceProtocol {

  var posts: [Post] = [.mock()]
  var getPostsCallCount = 0
  var error: APIError?

  func getPosts() -> AnyPublisher<[Post], APIError> {

    getPostsCallCount += 1

    if error != nil {
      return Fail(error: error!)
        .eraseToAnyPublisher()
    } else {
      return Just(posts)
        .setFailureType(to: APIError.self)
        .eraseToAnyPublisher()
    }
  }

  func reset() {
    getPostsCallCount = 0
    error = nil
  }
}
