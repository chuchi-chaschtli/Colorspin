//
//  MainMenuViewController.swift
//  Colorspin
//
//  Created by Anand Kumar on 8/10/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet private (set) var playButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        beautify()
        navigationController?.isNavigationBarHidden = true

        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }

    @objc private func playButtonTapped() {
        let gameSceneViewController = GameSceneViewController()
        navigationController?.pushViewController(gameSceneViewController, animated: true)
    }
}

// MARK: - Beautify
extension MainMenuViewController: Beautify {
    func beautify() {
        view.backgroundColor = .lightGray
    }
}
