import UIKit
import Combine

import Common
import PostsService
import UsersService

struct ForumPost {
  let username: String
  let title: String
}

public class PostsViewController: UIViewController {

  private var publishers = [AnyCancellable]()

  private let postService = PostsService()
  private let userService = UsersService()

  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .gray

    Publishers.Zip(userService.getUsers(), postService.getPosts())
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
