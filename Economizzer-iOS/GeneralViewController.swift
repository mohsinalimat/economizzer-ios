//
//  GeneralViewController.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 04/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit

final class GeneralViewController: UIViewController {

    enum CollectionItem {
        case generalBalance(GeneralBalanceViewModel)
        case accounts([AccountCellViewModel])
        case creditCard([CreditCardCellViewModel])
    }

    enum Constants {
        static let generalBalanceCellIdentifier = "GeneralBalanceCollectionViewCell"
        static let accountCellIdentifier = "AccountCollectionViewCell"
        static let sectionHeaderIdentifier = "GeneralSectionHeaderView"
        static let creditCardCellIdentifier = "CreditCardCollectionViewCell"
    }

    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        return collectionView
    }()

    var dataSource: [CollectionItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(GeneralBalanceCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.generalBalanceCellIdentifier)
        collectionView.register(AccountCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.accountCellIdentifier)
        collectionView.register(CreditCardCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.creditCardCellIdentifier)
        collectionView.register(GeneralSectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                withReuseIdentifier: Constants.sectionHeaderIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        dataSource.append(.generalBalance(GeneralBalanceViewModel(greeting: "Bom dia, Guilherme!", balance: 456.23, graphData: [])))
        dataSource.append(.accounts([AccountCellViewModel(accountName: "Itaú", categoryName: "Conta Corrente", iconImage: UIImage(), balance: 234.53),
                                     AccountCellViewModel(accountName: "Banco do Brasil", categoryName: "Conta Corrente", iconImage: UIImage(), balance: 65.53),
                                     AccountCellViewModel(accountName: "Carteira", categoryName: "Outros", iconImage: UIImage(), balance: 234.53)]))
        dataSource.append(.creditCard([CreditCardCellViewModel(cardName: "Nubank", iconImage: UIImage(), invoiceValue: -321.45, limitValue: 1234.56),
                                       CreditCardCellViewModel(cardName: "Nubank", iconImage: UIImage(), invoiceValue: -321.45, limitValue: 1234.56),
                                       CreditCardCellViewModel(cardName: "Nubank", iconImage: UIImage(), invoiceValue: -321.45, limitValue: 1234.56)]))
    }

    override func loadView() {
        super.loadView()
        view = collectionView
        setupView()
    }

    @objc fileprivate func addButtonTapped(_ sender: UIBarButtonItem) {
        let addMoveViewController = AddMoveViewController()
        let navController = UINavigationController(rootViewController: addMoveViewController)
        present(navController, animated: true)
    }

    fileprivate func generalBalanceTapped() {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

extension GeneralViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let item = dataSource[section]
        switch item {
        case .generalBalance: return 1
        case .accounts(let accounts): return accounts.count
        case .creditCard(let cards): return cards.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataSource[indexPath.section]

        switch item {
        case .generalBalance(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.generalBalanceCellIdentifier,
                                                      for: indexPath) as! GeneralBalanceCollectionViewCell
            cell.viewModel = viewModel
            return cell

        case .accounts(let accounts):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.accountCellIdentifier,
                                                      for: indexPath) as! AccountCollectionViewCell
            cell.viewModel = accounts[indexPath.item]
            cell.isSeparatorHidden = indexPath.item == (accounts.count - 1)
            return cell

        case .creditCard(let cards):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.creditCardCellIdentifier,
                                                          for: indexPath) as! CreditCardCollectionViewCell
            cell.viewModel = cards[indexPath.item]
            cell.isSeparatorHidden = indexPath.item == (cards.count - 1)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                               withReuseIdentifier: Constants.sectionHeaderIdentifier,
                                                               for: indexPath) as! GeneralSectionHeaderView

        let item = dataSource[indexPath.section]
        switch item {
        case .accounts:
            view.title = "Contas"
        case .creditCard:
            view.title = "Cartões de Crédito"
        default:
            break
        }

        return view
    }
}
extension GeneralViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let item = dataSource[section]

        switch item {
        case .generalBalance: return CGSize.zero
        case .accounts, .creditCard: return CGSize(width: collectionView.bounds.width, height: 48)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = dataSource[indexPath.section]
        switch item {
        case .generalBalance:
            return CGSize(width: collectionView.bounds.width, height: 196)

        case .accounts, .creditCard:
            return CGSize(width: collectionView.bounds.width, height: 48)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped(_:)))
    }
}
