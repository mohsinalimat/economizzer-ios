//
//  GeneralViewController.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 04/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit
import SnapKit

final class GeneralViewController: UIViewController {

    fileprivate lazy var generalBalanceView = GeneralBalanceView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func loadView() {
        super.loadView()
        setupView()
    }


    @objc fileprivate func addButtonTapped(_ sender: UIBarButtonItem) {

    }
}

// MARK: - View Configuration
extension GeneralViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(generalBalanceView)
    }

    func setupConstraints() {
        generalBalanceView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(196)
        }
    }

    func configureView() {
        title = "Visão Geral"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
    }
}
