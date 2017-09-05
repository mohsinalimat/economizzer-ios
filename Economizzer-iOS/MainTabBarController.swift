//
//  MainTabBarController.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 04/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {

    private let generalViewController = GeneralViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewControllers([
            UINavigationController(rootViewController: generalViewController)
            ], animated: true)
    }

}
