import UIKit
import Combine

import WindowsNetwork

struct ForumPost {
  let username: String
  let title: String
}

class PostsViewController: UIViewController {

  private var publishers = [AnyCancellable]()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .gray

    Publishers.Zip(getUsers(), getPosts())
      .sink(
        receiveCompletion: { [weak self] result in
          guard let self = self else {
            return
          }
          self.onComplete(result: result)
        },
        receiveValue: { [weak self] users, posts in
          guard let self = self else {
            return
          }
          self.onValue(users: users, posts: posts)
        })
      .store(in: &publishers)

    getComments(for: 1)
      .sink(
        receiveCompletion: onComplete,
        receiveValue: { [weak self] comments in
          guard let self = self else {
            return
          }
          print("Comments: \(comments)\n\n\n")
        })
      .store(in: &publishers)
  }

  public func getPosts() -> AnyPublisher<[Post], APIError> {
    let client = ForumClient()
    return client.execute(.posts)
  }

  public func getUsers() -> AnyPublisher<[User], APIError> {
    let client = ForumClient()
    return client.execute(.users)
  }

  public func getComments(for postId: Int) -> AnyPublisher<[Comment], APIError>  {
    let client = ForumClient()
    return client.execute(.comments(postId: postId))
  }

  private func onValue(users: [User], posts: [Post]) {
    let forumPosts = forumPosts(from: users, posts: posts)

    print(forumPosts)
  }

  func forumPosts(from users: [User], posts: [Post]) -> [ForumPost] {
    return users.reduce(into: []) { forumPosts, user in
      let usersPosts = posts
        .filter { $0.userId == user.id }
        .map { ForumPost(username: user.username, title: $0.title) }
      forumPosts.append(contentsOf: usersPosts)
    }
  }

  private func onComplete(result: Subscribers.Completion<APIError>) {
    switch result {
    case .failure(let error):
      print(error.message)
    default:
      break
    }
  }
}
