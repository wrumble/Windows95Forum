import UIKit
import Common

public class PostsViewController: UIViewController {

  private let viewModel: PostsViewModelProtocol

  public init(viewModel: PostsViewModelProtocol) {

    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .windowsBackground
    navigationController?.navigationBar.topItem?.title = "Posts"
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.navBarTitle]
  }

}

extension PostsViewController: Subviewable {
  public func setHierarchy() {

  }

  public func setUI() {

  }

  public func setLayout() {

  }
}
