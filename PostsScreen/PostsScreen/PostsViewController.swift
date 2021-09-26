import UIKit
import Combine

import Common

private struct Constants {
  static let windowsViewLeadingMargin: CGFloat = 4
  static let windowsViewTrailingMargin: CGFloat = -2
  static let windowsViewBottomMargin: CGFloat = -2
  static let tableViewTopMargin: CGFloat = 50
  static let tableViewLeadingMargin: CGFloat = 8
  static let tableViewTrailingMargin: CGFloat = -8
  static let tableViewBottomMargin: CGFloat = -8
}

public class PostsViewController: UIViewController {

  private let windowsView: WindowsView
  private let viewModel: PostsViewModelProtocol

  private let tableView = WindowsTableView()

  private var publishers = [AnyCancellable]()

  public init(viewModel: PostsViewModelProtocol) {

    self.viewModel = viewModel
    let windowsViewModel = WindowsViewModel(
      xButtonTapped: viewModel.xButtonTapped,
      titleText: viewModel.titleText,
      hideXButton: viewModel.hideXButton)
    self.windowsView = WindowsView(viewModel: windowsViewModel)

    super.init(nibName: nil, bundle: nil)

    setup()
    bindViewModel()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

}

// Mark: Private

private extension PostsViewController {
  func bindViewModel() {
    viewModel.errorReceived
      .receive(on: DispatchQueue.main)
      .sink(
        receiveValue: { [weak self] title, message in
          guard let self = self else {
            return
          }
          self.showAlert(title, message)
        })
      .store(in: &publishers)
  }

  func showAlert(_ title: String, _ message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}

// Mark: Subviewable

extension PostsViewController: Subviewable {
  public func setHierarchy() {
    view.addSubview(windowsView)
    view.addSubview(tableView)
  }

  public func setUI() {
    view.backgroundColor = .windowsBackground
  }

  public func setLayout() {
    setWindowsViewLayout()
    setTableViewLayout()
  }
}

// Mark: Private

extension PostsViewController {

  func setWindowsViewLayout() {
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

  func setTableViewLayout() {
    tableView.translatesAutoresizingMaskIntoConstraints = false

    tableView.topAnchor.constraint(
      equalTo: windowsView.topAnchor,
      constant: Constants.tableViewTopMargin).isActive = true
    tableView.leadingAnchor.constraint(
      equalTo: windowsView.leadingAnchor,
      constant: Constants.tableViewLeadingMargin).isActive = true
    tableView.trailingAnchor.constraint(
      equalTo: windowsView.trailingAnchor,
      constant: Constants.tableViewTrailingMargin).isActive = true
    tableView.bottomAnchor.constraint(
      equalTo: windowsView.bottomAnchor,
      constant: Constants.tableViewBottomMargin).isActive = true
  }
}

class WindowsTableView: UITableView {

  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func draw(_ rect: CGRect) {
    super.draw(rect)

    applyInternalWindows95Style()
  }
}

extension WindowsTableView: Subviewable {
  func setHierarchy() { }

  func setUI() {
    backgroundColor = .windowsWhite
  }

  func setLayout() { }
}
