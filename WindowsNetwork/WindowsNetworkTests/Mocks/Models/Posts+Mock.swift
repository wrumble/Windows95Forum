@testable import WindowsNetwork

extension Post {
  static func mock(
    userId: Int = 1,
    id: Int = 1,
    title: String = "title") -> Post {
      
    return .init(
      userId: userId,
      id: id,
      title: title)
  }
}
