public extension User {
  static func mock(
    id: Int = 1,
    username: String = "username") -> User {
    return .init(
      id: id,
      username: username)
  }
}
