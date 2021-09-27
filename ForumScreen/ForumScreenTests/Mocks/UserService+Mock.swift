import Combine

import Common
import UsersService

class UsersServiceMock: UsersServiceProtocol {

  var users: [User] = [.mock()]

  var getUsersCallCount = 0

  func getUsers() -> AnyPublisher<[User], APIError> {

    getUsersCallCount += 1

    return Just(users)
      .setFailureType(to: APIError.self)
      .eraseToAnyPublisher()
  }

  func reset() {
    getUsersCallCount = 0
  }
}
