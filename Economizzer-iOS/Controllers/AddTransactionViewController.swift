//
//  AddMoveViewController.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 05/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit

final class AddTransactionViewController: UIViewController {

    enum State: Int {
        case income
        case outcome
        case transfer
    }

    var state: State = .income {
        didSet {
            let color: UIColor
            switch state {
            case .income: color = UIColor(r: 33, g: 199, b: 209)
            case .outcome: color = UIColor.red
            case .transfer: color = UIColor.blue
            }

            navigationController?.navigationBar.barTintColor = color
            headerBackgroundView.backgroundColor = color
        }
    }

    fileprivate lazy var headerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 33, g: 199, b: 209)
        return view
    }()
    fileprivate lazy var moveTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "Receita", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Despesa", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Transferência", at: 2, animated: false)
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.addTarget(self, action: #selector(moveTypeChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()

    fileprivate lazy var valueTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "R$ 00.00"
        textField.borderStyle = .none
        textField.font = UIFont.boldSystemFont(ofSize: 24)
        textField.textAlignment = .right
        textField.textColor = .white
        return textField
    }()

    fileprivate lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        super.loadView()
        setupView()
    }

    @objc fileprivate func moveTypeChanged(_ sender: UISegmentedControl) {
        state = State(rawValue: sender.selectedSegmentIndex) ?? .income
    }

    @objc fileprivate func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @objc fileprivate func doneTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}

extension AddTransactionViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(headerBackgroundView)
        headerBackgroundView.addSubview(moveTypeSegmentedControl)
        headerBackgroundView.addSubview(valueTextField)
    }

    func setupConstraints() {
        headerBackgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        moveTypeSegmentedControl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }

        valueTextField.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-18)
            make.top.equalTo(moveTypeSegmentedControl.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
    }

    func configureView() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped(_:)))
    }
}
