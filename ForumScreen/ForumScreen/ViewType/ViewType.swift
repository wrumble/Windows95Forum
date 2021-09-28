public enum ViewType {
  case posts
  case comments
  case error

  var title: String {
    switch self {
    case .posts:
      return .posts
    case .comments:
      return .comments
    case .error:
      return .error
    }
  }

  var shouldHideXButton: Bool {
    switch self {
    case .posts:
      return true
    case .comments:
      return false
    case .error:
      return false
    }
  }
}
