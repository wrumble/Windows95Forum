import Combine

import Common
import ForumClient

public protocol CommentsServiceProtocol {
  func getComments(postId: Int) -> AnyPublisher<[Comment], APIError>
}

public final class CommentsService: CommentsServiceProtocol {
  private let client: ForumClientProtocol

  public required init(client: ForumClientProtocol = ForumClient()) {
    self.client = client
  }

  public func getComments(postId: Int) -> AnyPublisher<[Comment], APIError> {
    return client.execute(.comments(postId: postId))
  }
}
