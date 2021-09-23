import UIKit

import Common

public class PostsViewController: UIViewController {

  private let windowsView = WindowsView(titleText: "Posts")

  private let viewModel: PostsViewModelProtocol

  public init(viewModel: PostsViewModelProtocol) {

    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

}

extension PostsViewController: Subviewable {
  public func setHierarchy() {
    view.addSubview(windowsView)
  }

  public func setUI() {
    view.backgroundColor = .windowsBackground
  }

  public func setLayout() {
    windowsView.translatesAutoresizingMaskIntoConstraints = false

    windowsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    windowsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    windowsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    windowsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
}
