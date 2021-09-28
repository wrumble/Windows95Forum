import Combine

import Common
import UsersService

class UsersServiceMock: UsersServiceProtocol {

  var users: [User] = [.mock()]
  var getUsersCallCount = 0
  var error: APIError?

  func getUsers() -> AnyPublisher<[User], APIError> {

    getUsersCallCount += 1

    if error != nil {
      return Fail(error: error!)
        .eraseToAnyPublisher()
    } else {
      return Just(users)
        .setFailureType(to: APIError.self)
        .eraseToAnyPublisher()
    }
  }

  func reset() {
    getUsersCallCount = 0
    error = nil
  }
}
