import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        let searchViewController = SearchViewController()
        let navigation = UINavigationController(rootViewController: searchViewController)
        navigation.navigationBar.barTintColor = .white
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.isOpaque = false
        navigation.navigationBar.barStyle = .default
        navigation.tabBarItem.title = "Search"
        navigation.tabBarItem.image = UIImage(named: "search_tab_bar_icon")

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigation]

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

