public extension Comment {
  static func mock(
    postId: Int = 1,
    body: String = "text") -> Comment {

    return .init(
      postId: postId,
      body: body)
  }
}
