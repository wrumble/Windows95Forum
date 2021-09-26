import UIKit

import Common

private struct Constants {
  static let windowsViewLeadingMargin: CGFloat = 4
  static let windowsViewTrailingMargin: CGFloat = -2
  static let windowsViewBottomMargin: CGFloat = -2
}

public class PostsViewController: UIViewController {

  private let windowsView: WindowsView

  private let viewModel: PostsViewModelProtocol

  public init(viewModel: PostsViewModelProtocol) {

    self.viewModel = viewModel
    let windowsViewModel = WindowsViewModel(
      xButtonTapped: viewModel.xButtonTapped,
      titleText: viewModel.titleText,
      hideXButton: viewModel.hideXButton)
    self.windowsView = WindowsView(viewModel: windowsViewModel)

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
    windowsView.leadingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.leadingAnchor,
      constant: Constants.windowsViewLeadingMargin).isActive = true
    windowsView.trailingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.trailingAnchor,
      constant: Constants.windowsViewTrailingMargin).isActive = true
    windowsView.bottomAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.bottomAnchor,
      constant: Constants.windowsViewBottomMargin).isActive = true
  }
}
