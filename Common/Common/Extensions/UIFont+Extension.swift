import UIKit

extension UIFont {
  // NOTE: adding .systemFont(ofSize:) is required for tests in other modules that cant find custom fonts
  public static let topBarTitle = UIFont(name: "W95FA", size: 25) ?? .systemFont(ofSize: 25)
  public static let postCellTitle = UIFont(name: "W95FA", size: 20) ?? .systemFont(ofSize: 20)
  public static let postCellUsername = UIFont(name: "W95FA", size: 14) ?? .systemFont(ofSize: 14)
  public static let commentCell = UIFont(name: "W95FA", size: 20) ?? .systemFont(ofSize: 20)
}
