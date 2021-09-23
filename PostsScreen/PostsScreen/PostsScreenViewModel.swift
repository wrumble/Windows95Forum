import Combine

import Common
import PostsService
import UsersService

public protocol PostsViewModelProtocol {

}

public final class PostsViewModel: PostsViewModelProtocol {

  private let postsService: PostsServiceProtocol
  private let usersService: UsersServiceProtocol

  private var forumPosts: [ForumPost] = []
  private var publishers = [AnyCancellable]()

  public init(
    postsService: PostsServiceProtocol = PostsService(),
    usersService: UsersServiceProtocol = UsersService()) {
      self.postsService = postsService
      self.usersService = usersService

      getForumPosts()
  }
}

// Mark: Private

private extension PostsViewModel {
  func getForumPosts() {
    Publishers.Zip(usersService.getUsers(), postsService.getPosts())
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
    forumPosts = ForumPostFactory.forumPosts(from: users, posts: posts)
  }

  private func onComplete(result: Subscribers.Completion<APIError>) {
    switch result {
    case .failure(let error):
      // TODO: post alert
      print(error.message)
    default:
      break
    }
  }
}
