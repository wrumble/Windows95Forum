import Common

struct ForumCommentFactory {
  static func forumComments(from comments: [Comment]) -> [ForumComment] {
    return comments.map { ForumComment(id: $0.postId, text: $0.body) }
  }
}
