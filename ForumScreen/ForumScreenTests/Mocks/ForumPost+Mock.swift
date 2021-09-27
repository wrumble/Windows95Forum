@testable import ForumScreen

extension ForumPost {
  static func mock(
    id: Int = 1,
    username: String = "username",
    title: String = "title") -> ForumPost {

    return .init(
      id: id,
      username: username,
      title: title)
  }
}
