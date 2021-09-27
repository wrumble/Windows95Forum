import UIKit

import ForumScreen

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = scene as? UIWindowScene else {
      return
    }

    let window = UIWindow(windowScene: windowScene)
    let postsViewModel = ForumScreenViewModel()
    let postsViewController = ForumScreenViewController(viewModel: postsViewModel)
    let navigationController = UINavigationController(rootViewController: postsViewController)

    window.rootViewController = navigationController

    self.window = window

    window.makeKeyAndVisible()
  }
}

