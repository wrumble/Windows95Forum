import Combine

import Common
import PostsService
import UsersService

public protocol PostsViewModelProtocol {
  var xButtonTapped: PassthroughSubject<Void, Never> { get }
  var titleText: PassthroughSubject<String, Never> { get }
  var hideXButton: PassthroughSubject<Bool, Never> { get }
}

public final class PostsViewModel: PostsViewModelProtocol {

  public var xButtonTapped = PassthroughSubject<Void, Never>()
  public var titleText = PassthroughSubject<String, Never>()
  public var hideXButton = PassthroughSubject<Bool, Never>()

  private let postsService: PostsServiceProtocol
  private let usersService: UsersServiceProtocol
  private let viewType = PassthroughSubject<ViewType, Never>()

  private var forumPosts: [ForumPost] = []
  private var publishers = [AnyCancellable]()

  public init(
    postsService: PostsServiceProtocol = PostsService(),
    usersService: UsersServiceProtocol = UsersService()) {
      self.postsService = postsService
      self.usersService = usersService

      setupObservers()
      getForumPosts()
  }
}

// Mark: Private

private extension PostsViewModel {
  func setupObservers() {
    viewType
      .sink(
        receiveValue: { [weak self] viewType in
          guard let self = self else {
            return
          }
          self.titleText.send(viewType.title)
          self.hideXButton.send(viewType.shouldHideXButton)
        })
      .store(in: &publishers)

    xButtonTapped
      .sink(
        receiveValue: { [weak self] _ in
          guard let self = self else {
            return
          }
          self.getForumPosts()
        })
      .store(in: &publishers)
  }

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
    viewType.send(.posts)
  }

  private func onComplete(result: Subscribers.Completion<APIError>) {
    switch result {
    case .failure(let error):
      // TODO: post alert
      viewType.send(.error)
      print(error.message)
    default:
      break
    }
  }
}
