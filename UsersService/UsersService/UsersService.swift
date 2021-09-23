import Combine

import Common
import ForumClient

public protocol UsersServiceProtocol {
  func getUsers() -> AnyPublisher<[User], APIError>
}

public class UsersService: UsersServiceProtocol {
  private let client: ForumClientProtocol

  public required init(client: ForumClientProtocol = ForumClient()) {
    self.client = client
  }

  public func getUsers() -> AnyPublisher<[User], APIError> {
    return client.execute(.users)
  }
}
