import XCTest

import Common

@testable import PostsScreen

private struct Constants {
  static let postCellUsername = "username"
  static let postCellTitle = "title"
}
class PostsViewModelTests: XCTestCase {

  private let tableView = UITableView()
  private let postsService = PostsServiceMock()
  private let usersService = UsersServiceMock()
  private let commentsService = CommentsServiceMock()

  private var postsViewModel: PostsViewModel!

  override func setUp() {
    postsViewModel = PostsViewModel(
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
    let numberOfRows = postsViewModel.numberOfRowsForData()

    XCTAssertEqual(numberOfRows, 1)
  }

  func testReturnsCorrectNumberOfRows_WhenGetCommentPostsCalled() throws {
    let indexPath = IndexPath(row: 0, section: 0)
    postsViewModel.didSelectRow.send(indexPath)

    let numberOfRows = postsViewModel.numberOfRowsForData()

    XCTAssertEqual(numberOfRows, 2)
  }

  func testReturnsCorrectCellType_WhenCellForRowCalled_AfterInit() throws {
    tableView.register(PostCell.self)

    let indexPath = IndexPath(row: 0, section: 0)
    let cell = postsViewModel.cellForRow(at: indexPath, tableView: tableView)

    XCTAssertTrue(cell is PostCell)
  }

  func testReturnsCorrectCellType_WhenCellForRowCalled_AfterDidSelectRow() throws {
    tableView.register(CommentCell.self)

    let indexPath = IndexPath(row: 0, section: 0)
    postsViewModel.didSelectRow.send(indexPath)

    let cell = postsViewModel.cellForRow(at: indexPath, tableView: tableView)

    XCTAssertTrue(cell is CommentCell)
  }

  func testXButtonTapped_CallsUsersServiceGetUsers() throws {
    usersService.reset()

    postsViewModel.xButtonTapped.send()

    XCTAssertEqual(usersService.getUsersCallCount, 1)
  }

  func testXButtonTapped_CallsPostsServiceGetPosts() throws {
    postsService.reset()

    postsViewModel.xButtonTapped.send()

    XCTAssertEqual(postsService.getPostsCallCount, 1)
  }
}
