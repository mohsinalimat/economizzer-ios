//
//  GeneralViewController.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 04/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

final class GeneralViewController: UIViewController {

    enum Sections: Int {
        case generalBalance
    }

    enum Constants {
        static let generalBalanceCellIdentifier = "GeneralBalanceCollectionViewCell"
    }

    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(GeneralBalanceCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.generalBalanceCellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func loadView() {
        super.loadView()
        view = collectionView
        setupView()
    }

    @objc fileprivate func addButtonTapped(_ sender: UIBarButtonItem) {

    }

    fileprivate func generalBalanceTapped() {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

extension GeneralViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Sections(rawValue: section) else { return 0 }

        switch section {
        case .generalBalance: return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Sections(rawValue: indexPath.section) else {
            fatalError()
        }

        let cell: UICollectionViewCell

        switch section {
        case .generalBalance:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.generalBalanceCellIdentifier,
                                                      for: indexPath)
            (cell as! GeneralBalanceCollectionViewCell).viewModel = GeneralBalanceViewModel(greeting: "Good morning, Guilherme!", balance: 456.23, graphData: [])

        }

        return cell
    }
}
extension GeneralViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 196)
    }

}
extension GeneralViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            generalBalanceTapped()
        }
    }

}

// MARK: - View Configuration
extension GeneralViewController: ViewConfigurator {
    func buildViewHierarchy() {}
    func setupConstraints() {}

    func configureView() {
        title = "Visão Geral"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
    }
}
