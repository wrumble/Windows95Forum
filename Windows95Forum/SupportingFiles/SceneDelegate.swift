//
//  SceneDelegate.swift
//  Windows95Forum
//
//  Created by Wayne Rumble on 22/09/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = scene as? UIWindowScene else {
      return
    }

    let window = UIWindow(windowScene: windowScene)
    let postsViewController = PostsViewController()
    let navigationController = UINavigationController(rootViewController: postsViewController)

    window.rootViewController = navigationController

    self.window = window

    window.makeKeyAndVisible()
  }
}

