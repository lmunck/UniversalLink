//
//  SceneDelegate.swift
//  UniversalLink
//
//  Created by Anders Munck on 16/06/2020.
//  Copyright © 2020 Anders Munck. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    lazy var appState = AppState()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView().environmentObject(appState)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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
    
    
    // Parse Universal Link v3
    /*func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
      for context in URLContexts {
        
        
        print("url: \(context.url.absoluteURL)")
        //print("scheme: \(context.url.scheme)")
        //print("host: \(context.url.host)")
        print("path: \(context.url.path)")
        print("components: \(context.url.pathComponents)")
      }
    }*/

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
      guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
        let url = userActivity.webpageURL else {
          return
      }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        for queryItem in components?.queryItems ?? [] {
            if queryItem.name == "publicid" {
                
                if queryItem.value != "" {
                    appState.publicid = queryItem.value ?? "" // MARK: This code doesn't get executed, and publicID doesn't get updated with value from URL
                }
                
                // URL to server-file https://qualk.dk/apple-app-site-association
                // Test link to use https://qualk.dk/?publicid=myPublicID
            }
        }

      print("[SceneDelegate] \(url)")
    }
    
    // Parse Universal Link v1
    /*func scene(_ scene: UIScene, openURLContexts urlContexts: Set<UIOpenURLContext>) {
        
        print("SceneDelegate v1")
        
        // Parse the deep link
        guard let url = urlContexts.first?.url,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        for queryItem in components.queryItems ?? [] {
            if queryItem.name == "publicid" {
                
                if queryItem.value != "" {
                    appState.publicid = queryItem.value ?? "" // MARK: This code doesn't get executed, and publicID doesn't get updated with value from URL
                }
                
                // URL to server-file https://qualk.dk/apple-app-site-association
                // Test link to use https://qualk.dk/?publicid=myPublicID
            }
        }
    }*/
    
    // Parse Universal Link v2
    /*func scene(_ scene: UIScene, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        print("SceneDelegate v2")
        
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return false }
        
        for queryItem in components.queryItems ?? [] {
            if queryItem.name == "publicid" {
                
                if queryItem.value != "" {
                    appState.publicid = queryItem.value ?? "" // MARK: This code doesn't get executed, and publicID doesn't get updated with value from URL
                }
                
                // URL to server-file https://qualk.dk/apple-app-site-association
                // Test link to use https://qualk.dk/?publicid=myPublicID
            }
        }
        
        return true
    }*/


}

