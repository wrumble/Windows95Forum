import UIKit

private struct Constants {
  static let horizontalMargin: CGFloat = 4
  static let verticalMargin: CGFloat = 4
}

public class CommentCell: ReusableTableViewCell {

  private let bodyLabel = UILabel()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: PostCell.identifier)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  public func configure(with cellData: CommentCellData) {
    bodyLabel.text = cellData.body
  }
}

// MARK: Subviewable

extension CommentCell: Subviewable {
  public func setHierarchy() {
    contentView.addSubview(bodyLabel)
  }

  public func setUI() {
    bodyLabel.font = .commentCell
    bodyLabel.numberOfLines = 0
  }

  public func setLayout() {
    setBodyLabelLayout()
  }
}

// MARK: Private

extension CommentCell {

  func setBodyLabelLayout() {
    bodyLabel.translatesAutoresizingMaskIntoConstraints = false

    bodyLabel.leadingAnchor.constraint(
      equalTo: contentView.leadingAnchor,
      constant: Constants.horizontalMargin).isActive = true
    bodyLabel.trailingAnchor.constraint(
      equalTo: contentView.trailingAnchor,
      constant: -Constants.horizontalMargin).isActive = true
    bodyLabel.topAnchor.constraint(
      equalTo: contentView.topAnchor,
      constant: Constants.verticalMargin).isActive = true
    bodyLabel.bottomAnchor.constraint(
      equalTo: contentView.bottomAnchor,
      constant: -Constants.verticalMargin).isActive = true

  }
}
