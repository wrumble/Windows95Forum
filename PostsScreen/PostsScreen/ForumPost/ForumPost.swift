public protocol ForumData { }

struct ForumPost: ForumData {
  let id: Int
  let username: String
  let title: String
}

struct ForumComment: ForumData {
  let text: String
}
