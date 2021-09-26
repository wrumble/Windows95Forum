public enum ViewType {
  case posts
  case comments
  case error

  var title: String {
    switch self {
    case .posts:
      return "Posts"
    case .comments:
      return "Comments"
    case .error:
      return "Error"
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
