import Combine

import ForumClient

public protocol PostsServiceProtocol {
  func getPosts() -> AnyPublisher<[Post], APIError>
}

public class PostsService: PostsServiceProtocol {
  private let client: ForumClientProtocol

  public required init(client: ForumClientProtocol = ForumClient()) {
    self.client = client
  }

  public func getPosts() -> AnyPublisher<[Post], APIError> {
    return client.execute(.posts)
  }
}