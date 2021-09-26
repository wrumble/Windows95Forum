import UIKit

import Common

public protocol ForumCellFactoryProtocol {
  static func registerCells(tableView: UITableView)
  func cellForRow(
    at indexPath: IndexPath,
    data: [ForumData],
    viewType: ViewType,
    tableView: UITableView) -> ReusableTableViewCell?
}

public class ForumCellFactory: ForumCellFactoryProtocol {

  public init() { }

  public static func registerCells(tableView: UITableView) {
    tableView.register(PostCell.self)
    tableView.register(CommentCell.self)
  }

  public func cellForRow(
    at indexPath: IndexPath,
    data: [ForumData],
    viewType: ViewType,
    tableView: UITableView) -> ReusableTableViewCell? {
      switch viewType {
      case .posts:
        return postCell(for: indexPath, data: data, tableView: tableView)
      case .comments:
        return commentCell(for: indexPath, data: data, tableView: tableView)
      default:
        return nil
      }
  }

  private func postCell(for indexPath: IndexPath, data: [ForumData], tableView: UITableView) -> PostCell? {
    guard let postData = data as? [ForumPost] else {
      return nil
    }
    
    let cell: PostCell = tableView.dequeue(for: indexPath)
    let forumPost = postData[indexPath.row]
    let cellData = PostCellData(username: forumPost.username, title: forumPost.title)

    cell.configure(with: cellData)

    return cell
  }

  private func commentCell(for indexPath: IndexPath, data: [ForumData], tableView: UITableView) -> CommentCell? {
    guard let commentData = data as? [ForumComment] else {
      return nil
    }

    let cell: CommentCell = tableView.dequeue(for: indexPath)
    let forumComment = commentData[indexPath.row]
    let cellData = CommentCellData(body: forumComment.text)

    cell.configure(with: cellData)

    return cell
  }
}
