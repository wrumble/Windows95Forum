import Combine

public protocol WindowsViewModelProtocol {
  var xButtonTapped: PassthroughSubject<Void, Never> { get }
  var titleText: PassthroughSubject<String, Never> { get }
  var hideXButton: PassthroughSubject<Bool, Never> { get }
}

public final class WindowsViewModel: WindowsViewModelProtocol {
  public var xButtonTapped: PassthroughSubject<Void, Never>
  public var titleText: PassthroughSubject<String, Never>
  public var hideXButton: PassthroughSubject<Bool, Never>

  private var publishers = [AnyCancellable]()

  public init(
    xButtonTapped: PassthroughSubject<Void, Never>,
    titleText: PassthroughSubject<String, Never>,
    hideXButton: PassthroughSubject<Bool, Never>
  ) {
    self.xButtonTapped = xButtonTapped
    self.titleText = titleText
    self.hideXButton = hideXButton
  }
}
