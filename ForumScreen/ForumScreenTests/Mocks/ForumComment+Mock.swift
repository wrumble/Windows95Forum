@testable import ForumScreen

extension ForumComment {
  static func mock(
    id: Int = 1,
    text: String = "text") -> ForumComment {

    return .init(id: id, text: text)
  }
}
