//
//  SceneDelegate.swift
//  IRCV
//
//  Created by Nuno Salvador on 13/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var rootCoordinator: RootCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        rootCoordinator = RootBuilder().make(window: window)
        window.makeKeyAndVisible()
    }
}
