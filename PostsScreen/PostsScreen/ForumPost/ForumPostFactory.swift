import Common

struct ForumPostFactory {
  static func forumPosts(from users: [User], posts: [Post]) -> [ForumPost] {
    return users.reduce(into: []) { forumPosts, user in
      let usersPosts = posts
        .filter { $0.userId == user.id }
        .map { ForumPost(username: user.username, title: $0.title) }
      forumPosts.append(contentsOf: usersPosts)
    }
  }
}
