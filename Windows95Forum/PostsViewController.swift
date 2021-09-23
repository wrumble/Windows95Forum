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

    Publishers.Zip(getPosts(), getUsers())
      .sink(receiveCompletion: onComplete,
            receiveValue: onValue)
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

  private func onValue(posts: [Post], users: [User]) {
    var forumPosts: [ForumPost] = []

    posts.forEach { post in
      users.forEach { user in
        if user.id == post.userId {
          let forumPost = ForumPost(username: user.username, title: post.title)
          forumPosts.append(forumPost)
        }
      }
    }

    print(forumPosts)
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
