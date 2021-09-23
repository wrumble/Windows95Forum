public enum Endpoint: Equatable {
  case posts
  case users
  case comments(postId: Int)

  var path: String {
    switch self {
    case .posts:
      return "posts"
    case .users:
      return "users"
    case .comments(let postId):
      return "posts/\(postId)/comments"
    }
  }
}
