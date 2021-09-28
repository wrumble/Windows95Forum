import XCTest
import Combine

import Common

@testable import ForumScreen

private struct Constants {
  static let errorMessage = "Oooooops"
  static let postCellUsername = "username"
  static let postCellTitle = "title"
}
class ForumScreenViewModelTests: XCTestCase {

  private let indexPath = IndexPath(row: 0, section: 0)
  private let tableView = UITableView()
  private var publishers = [AnyCancellable]()
  private let postsService = PostsServiceMock()
  private let usersService = UsersServiceMock()
  private let commentsService = CommentsServiceMock()

  private var forumScreenViewModel: ForumScreenViewModel!

  override func setUp() {
    forumScreenViewModel = ForumScreenViewModel(
      postsService: postsService,
      usersService: usersService,
      commentsService: commentsService)
  }

  override func tearDown() {
    postsService.reset()
    usersService.reset()
    commentsService.reset()
  }

  func testReturnsCorrectNumberOfRows_WhenGetForumPostsCalledAtInit() throws {
    let numberOfRows = forumScreenViewModel.numberOfRowsForData()

    XCTAssertEqual(numberOfRows, 1)
  }

  func testReturnsZeroRows_WhenGetForumPostsFailsAtInit() throws {
    postsService.error = .server(Constants.errorMessage)

    forumScreenViewModel = ForumScreenViewModel(
      postsService: postsService,
      usersService: usersService,
      commentsService: commentsService)

    let numberOfRows = forumScreenViewModel.numberOfRowsForData()

    XCTAssertEqual(numberOfRows, 0)
  }

  func testReturnsCorrectNumberOfRows_WhenGetCommentPostsCalled() throws {
    forumScreenViewModel.didSelectRow.send(indexPath)

    let numberOfRows = forumScreenViewModel.numberOfRowsForData()

    XCTAssertEqual(numberOfRows, 2)
  }

  func testReturnsZeroRows_WhenGetCommentsReturnError() throws {
    commentsService.error = .parsing(Constants.errorMessage)
    forumScreenViewModel.didSelectRow.send(indexPath)

    let numberOfRows = forumScreenViewModel.numberOfRowsForData()

    XCTAssertEqual(numberOfRows, 0)
  }

  func testReturnsCorrectCellType_WhenCellForRowCalled_AfterInit() throws {
    tableView.register(PostCell.self)

    let cell = forumScreenViewModel.cellForRow(at: indexPath, tableView: tableView)

    XCTAssertTrue(cell is PostCell)
  }

  func testReturnsCorrectCellType_WhenCellForRowCalled_AfterDidSelectRow() throws {
    tableView.register(CommentCell.self)

    forumScreenViewModel.didSelectRow.send(indexPath)

    let cell = forumScreenViewModel.cellForRow(at: indexPath, tableView: tableView)

    XCTAssertTrue(cell is CommentCell)
  }

  func testXButtonTapped_CallsUsersServiceGetUsers() throws {
    usersService.reset()

    forumScreenViewModel.xButtonTapped.send()

    XCTAssertEqual(usersService.getUsersCallCount, 1)
  }

  func testXButtonTapped_CallsPostsServiceGetPosts() throws {
    postsService.reset()

    forumScreenViewModel.xButtonTapped.send()

    XCTAssertEqual(postsService.getPostsCallCount, 1)
  }

  func testErrorReceivedSubjectIsCalled_WhenErrorComesFromPostsService() throws {
    postsService.error = .server(Constants.errorMessage)

    forumScreenViewModel = ForumScreenViewModel(
      postsService: postsService,
      usersService: usersService,
      commentsService: commentsService)

    forumScreenViewModel.errorReceived
      .sink(
        receiveCompletion: { result in
          switch result {
          case .finished:
            XCTFail("Should not have finished without errors")
          }
        },
        receiveValue: { error in
          XCTAssertEqual(error, self.postsService.error)
        })
      .store(in: &publishers)
  }

  func testErrorReceivedSubjectIsCalled_WhenErrorComesFromUsersService() throws {
    usersService.error = .parsing(Constants.errorMessage)

    forumScreenViewModel = ForumScreenViewModel(
      postsService: postsService,
      usersService: usersService,
      commentsService: commentsService)

    forumScreenViewModel.errorReceived
      .sink(
        receiveCompletion: { result in
          switch result {
          case .finished:
            XCTFail("Should not have finished without errors")
          }
        },
        receiveValue: { error in
          XCTAssertEqual(error, self.usersService.error)
        })
      .store(in: &publishers)
  }

  func testErrorReceivedSubjectIsCalled_WhenErrorComesFromCommentsService() throws {
    commentsService.error = .parsing(Constants.errorMessage)

    forumScreenViewModel.didSelectRow.send(indexPath)

    forumScreenViewModel.errorReceived
      .sink(
        receiveCompletion: { result in
          switch result {
          case .finished:
            XCTFail("Should not have finished without errors")
          }
        },
        receiveValue: { error in
          XCTAssertEqual(error, self.commentsService.error)
        })
      .store(in: &publishers)
  }
}
