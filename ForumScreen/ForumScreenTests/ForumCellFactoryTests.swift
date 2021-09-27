import XCTest

import Common

@testable import ForumScreen

class ForumCellFactoryTests: XCTestCase {

  private let factory = ForumCellFactory()
  private let tableView = UITableView()
  private let indexPath = IndexPath(row: 0, section: 0)

  override func setUp() {
    tableView.register(PostCell.self)
    tableView.register(CommentCell.self)
  }

  func test_ReturnsAPostCell_WhenViewTypeIsPosts() throws {
    let cell = factory.cellForRow(
      at: indexPath,
      data: [ForumPost.mock()],
      viewType: .posts,
      tableView: tableView)

    XCTAssertTrue(cell is PostCell)
  }

  func test_ReturnsNil_WhenDataIsForumComment_AndViewTypeIsPosts() throws {
    let cell = factory.cellForRow(
      at: indexPath,
      data: [ForumComment.mock()],
      viewType: .posts,
      tableView: tableView)

    XCTAssertNil(cell)
  }

  func test_ReturnsACommentCell_WhenViewTypeIsComments() throws {
    let cell = factory.cellForRow(
      at: indexPath,
      data: [ForumComment.mock()],
      viewType: .comments,
      tableView: tableView)

    XCTAssertTrue(cell is CommentCell)
  }

  func test_ReturnsNil_WhenDataIsForumPost_AndViewTypeIsComments() throws {
    let cell = factory.cellForRow(
      at: indexPath,
      data: [ForumPost.mock()],
      viewType: .comments,
      tableView: tableView)

    XCTAssertNil(cell)
  }
}
