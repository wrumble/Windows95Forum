import Combine

import Common
import PostsService
import UsersService
import CommentsService
import UIKit

public protocol ForumScreenViewModelProtocol {
  var xButtonTapped: PassthroughSubject<Void, Never> { get }
  var titleText: PassthroughSubject<String, Never> { get }
  var hideXButton: PassthroughSubject<Bool, Never> { get }
  var reloadTableView: PassthroughSubject<Void, Never> { get }
  var errorReceived: PassthroughSubject<APIError, Never> { get }
  var didSelectRow: PassthroughSubject<IndexPath, Never> { get }

  func numberOfRowsForData() -> Int
  func cellForRow(at indexPath: IndexPath, tableView: UITableView) -> ReusableTableViewCell?
}

public final class ForumScreenViewModel: ForumScreenViewModelProtocol {

  public var xButtonTapped = PassthroughSubject<Void, Never>()
  public var titleText = PassthroughSubject<String, Never>()
  public var hideXButton = PassthroughSubject<Bool, Never>()
  public var reloadTableView = PassthroughSubject<Void, Never>()
  public var errorReceived = PassthroughSubject<APIError, Never>()
  public var didSelectRow = PassthroughSubject<IndexPath, Never>()

  private let postsService: PostsServiceProtocol
  private let usersService: UsersServiceProtocol
  private let commentsService: CommentsServiceProtocol
  private let forumCellFactory: ForumCellFactoryProtocol

  private let viewType = PassthroughSubject<ViewType, Never>()

  private var currentViewType: ViewType = .posts
  private var forumData: [ForumData] = []
  private var publishers = [AnyCancellable]()

  public init(
    postsService: PostsServiceProtocol = PostsService(),
    usersService: UsersServiceProtocol = UsersService(),
    commentsService: CommentsServiceProtocol = CommentsService(),
    forumCellFactory: ForumCellFactoryProtocol = ForumCellFactory()) {
      self.postsService = postsService
      self.usersService = usersService
      self.commentsService = commentsService
      self.forumCellFactory = forumCellFactory

      setupObservers()
      getForumPosts()
  }

  public func numberOfRowsForData() -> Int {
    return forumData.count
  }

  public func cellForRow(at indexPath: IndexPath, tableView: UITableView) -> ReusableTableViewCell? {
    return forumCellFactory.cellForRow(
      at: indexPath,
      data: forumData,
      viewType: currentViewType,
      tableView: tableView)
  }
}

// MARK: Private

private extension ForumScreenViewModel {
  func setupObservers() {
    viewType
      .sink(
        receiveValue: { [weak self] viewType in
          guard let self = self else {
            return
          }
          self.currentViewType = viewType
          self.titleText.send(viewType.title)
          self.hideXButton.send(viewType.shouldHideXButton)
          self.reloadTableView.send()
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

    didSelectRow
      .sink(
        receiveValue: { [weak self] indexPath in
          guard let self = self else {
            return
          }
          self.onDidTapRow(indexPath: indexPath)
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
          self.onReceived(users: users, posts: posts)
        })
      .store(in: &publishers)
  }

  func onReceived(users: [User], posts: [Post]) {
    forumData = ForumPostFactory.forumPosts(from: users, posts: posts)
    viewType.send(.posts)
  }

  func getForumComments(with postId: Int) {
    commentsService.getComments(postId: postId)
      .sink(
        receiveCompletion: { [weak self] result in
          guard let self = self else {
            return
          }
          self.onComplete(result: result)
        },
        receiveValue: { [weak self] comments in
          guard let self = self else {
            return
          }
          self.onReceived(comments: comments)
        })
      .store(in: &publishers)
  }

  func onDidTapRow(indexPath: IndexPath) {
    switch currentViewType {
    case .posts:
      let postId = self.forumData[indexPath.row].id
      self.getForumComments(with: postId)
    default:
      break
    }
  }

  func onReceived(comments: [Comment]) {
    forumData = ForumCommentFactory.forumComments(from: comments)
    viewType.send(.comments)
  }

  func onComplete(result: Subscribers.Completion<APIError>) {
    switch result {
    case .failure(let error):
      viewType.send(.error)
      errorReceived.send(error)
    default:
      break
    }
  }
}
