import UIKit
import Combine

import Common

private struct Constants {
  static let windowsViewLeadingMargin: CGFloat = 4
  static let windowsViewTrailingMargin: CGFloat = -2
  static let windowsViewBottomMargin: CGFloat = -2
  static let tableViewTopMargin: CGFloat = WindowsViewConstants.topBarTopMargin +
                                           WindowsViewConstants.topBarHeight + 20
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

// MARK: Private

private extension PostsViewController {
  func bindViewModel() {
    viewModel.errorReceived
      .receive(on: DispatchQueue.main)
      .sink(
        receiveValue: { [weak self] error in
          guard let self = self else {
            return
          }
          self.showAlert(for: error)
        })
      .store(in: &publishers)

    viewModel.reloadTableView
      .receive(on: DispatchQueue.main)
      .sink(
        receiveValue: { [weak self] _ in
          guard let self = self else {
            return
          }
          self.tableView.reloadData()
        })
      .store(in: &publishers)
  }

  func showAlert(for error: APIError) {
    let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}

// MARK: Subviewable

extension PostsViewController: Subviewable {
  public func setHierarchy() {
    view.addSubview(windowsView)
    view.addSubview(tableView)
  }

  public func setUI() {
    view.backgroundColor = .windowsBackground

    tableView.delegate = self
    tableView.dataSource = self
    
    ForumCellFactory.registerCells(tableView: tableView)
  }

  public func setLayout() {
    setWindowsViewLayout()
    setTableViewLayout()
  }
}

// MARK: TableView Delegate

extension PostsViewController: UITableViewDelegate {

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelectRow.send(indexPath)
  }
}

// MARK: TableView Datasource

extension PostsViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = viewModel.cellForRow(at: indexPath, tableView: tableView) else {
      return UITableViewCell()
    }
    return cell
  }


  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsForData()
  }
}

// MARK: Private

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
