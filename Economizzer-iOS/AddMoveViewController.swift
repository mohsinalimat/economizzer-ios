//
//  AddMoveViewController.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 05/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit

final class AddMoveViewController: UIViewController {

    fileprivate lazy var moveTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "Receita", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Despesa", at: 2, animated: false)
        segmentedControl.insertSegment(withTitle: "Transferência", at: 3, animated: false)
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func loadView() {
        super.loadView()
        setupView()
    }

    @objc fileprivate func doneTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

}

extension AddMoveViewController: ViewConfigurator {
    func buildViewHierarchy() {

    }

    func setupConstraints() {

    }

    func configureView() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped(_:)))
    }
}
