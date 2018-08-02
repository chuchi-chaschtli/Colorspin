//
//  GameSceneViewController.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/14/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import SpriteKit

class GameSceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.currentlevel < 1 {
            UserDefaults.set(currentLevel: 1)
        }

        if let view = (self.view as? SKView) {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
