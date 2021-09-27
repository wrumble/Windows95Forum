import UIKit

private struct Constants {
  static let horizontalMargin: CGFloat = 4
  static let verticalMargin: CGFloat = 4
}

public class PostCell: ReusableTableViewCell {

  private let usernameLabel = UILabel()
  private let titleLabel = UILabel()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: PostCell.identifier)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  public func configure(with cellData: PostCellData) {
    usernameLabel.text = cellData.username
    titleLabel.text = cellData.title
  }
}

// MARK: Subviewable

extension PostCell: Subviewable {
  public func setHierarchy() {
    contentView.addSubview(usernameLabel)
    contentView.addSubview(titleLabel)
  }

  public func setUI() {
    usernameLabel.font = .postCellUsername
    usernameLabel.numberOfLines = 1

    titleLabel.font = .postCellTitle
    titleLabel.numberOfLines = 0
  }

  public func setLayout() {
    setUsernameLabelLayout()
    setTitleLabelLayout()
  }
}

// MARK: Private

extension PostCell {
  func setUsernameLabelLayout() {
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false

    usernameLabel.leadingAnchor.constraint(
      equalTo: contentView.leadingAnchor,
      constant: Constants.horizontalMargin).isActive = true
    usernameLabel.trailingAnchor.constraint(
      equalTo: contentView.trailingAnchor,
      constant: -Constants.horizontalMargin).isActive = true
    usernameLabel.topAnchor.constraint(
      equalTo: contentView.topAnchor,
      constant: Constants.verticalMargin).isActive = true
    usernameLabel.bottomAnchor.constraint(
      equalTo: titleLabel.topAnchor,
      constant: -Constants.verticalMargin).isActive = true
  }

  func setTitleLabelLayout() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    titleLabel.leadingAnchor.constraint(
      equalTo: contentView.leadingAnchor,
      constant: Constants.horizontalMargin).isActive = true
    titleLabel.trailingAnchor.constraint(
      equalTo: contentView.trailingAnchor,
      constant: -Constants.horizontalMargin).isActive = true
    titleLabel.topAnchor.constraint(
      equalTo: usernameLabel.bottomAnchor,
      constant: Constants.verticalMargin).isActive = true
    titleLabel.bottomAnchor.constraint(
      equalTo: contentView.bottomAnchor,
      constant: -Constants.verticalMargin).isActive = true

  }
}
