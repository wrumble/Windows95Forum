import Combine

import Common
import PostsService

class PostsServiceMock: PostsServiceProtocol {

  var posts: [Post] = [.mock()]

  var getPostsCallCount = 0

  func getPosts() -> AnyPublisher<[Post], APIError> {

    getPostsCallCount += 1

    return Just(posts)
      .setFailureType(to: APIError.self)
      .eraseToAnyPublisher()
  }

  func reset() {
    getPostsCallCount = 0
  }
}
