//
//  SceneDelegate.swift
//  TopNews
//
//  Created by iso karo on 28.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        //create an instance of UIWindow
        window = UIWindow(windowScene: windowScene)
        window?.windowScene=windowScene
        //make the window visible
        window?.makeKeyAndVisible()
//the ViewController(ViewController.swift file) class inherits UICollectionviewController and it needs a layout so we have to create this layout ,if the ViewcController class inherited UIViewController ,remove the line below ,the layout.Watch this:  www.youtube.com/watch?v=3Xv1mJvwXok&list=PL0dzCUj1L5JGKdVUtA5xds1zcyzsz7HLj&index=3
        let layout = UICollectionViewFlowLayout()
//        //this is to make the ViewController move horizontally
//        layout.scrollDirection = .horizontal
        
//*********************This code below is an alternative to set a Navigationcontroller like we did right below, but it uses frames so the navbar that is the top most part is set but it is old way of doing it because we have to define the height of navbar using frames,NavigationController is the main object which has the navigationbar
//        //Create UINavigationController and UINavigationBar ,UINavigationBar is the top part
//      let nav=UINavigationController(rootViewController: ViewController())
//      let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: (window?.frame.width)!, height: 49))
//        navBar.backgroundColor = .white
//        UINavigationBar.appearance().isTranslucent = false
//        window?.addSubview(navBar)
//*********************

        
//Below we set NavigationController and NavigationBar properties so ,this will apply to the entire app meaning that all the navigation bar settings set below will be used according to the settings below.This is a better way since it sets navbar for different device screens automatically.Remember UINavigationController is an object which has a navigationbar property in it which is the top bar where we show navigation error , navigation title and etc.. Also remember we start from the ViewController which is in ViewController.swift file.
        let nc=UINavigationController(rootViewController: ViewController(collectionViewLayout: layout))
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
//Navigation bar is the place right below statusbar(the time and batter place)
        nc.navigationBar.tintColor = .white
        nc.navigationBar.standardAppearance = appearance
        nc.navigationBar.compactAppearance = appearance
        nc.navigationBar.scrollEdgeAppearance = appearance
        
    
        
////********    This is the code if you want to put a view on a status bar
//        let vi = UIView(frame: CGRect(x: 0, y: 0, width: (window?.frame.width)!, height: 35))
//        UINavigationBar.appearance().isTranslucent = false
//        vi.backgroundColor = .purple
//        window?.addSubview(vi)
        
        
   
        
//add a NavigationController to the main rootViewController
                window?.rootViewController = nc
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

