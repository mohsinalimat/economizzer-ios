//
//  AddMoveViewController.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 05/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit

final class AddTransactionViewController: UIViewController {

    enum TextFieldTag: Int {
        case value = 100
        case category
        case account
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

        segmentedControl.addTarget(self, action: #selector(transactionTypeChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()

    fileprivate lazy var valueTextField: UITextField = {
        let textField = UITextField()
        textField.tag = TextFieldTag.value.rawValue
        textField.placeholder = self.numberFormatter.string(from: NSNumber(value: 0))
        textField.borderStyle = .none
        textField.font = UIFont.boldSystemFont(ofSize: 34)
        textField.textAlignment = .right
        textField.textColor = .white
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()

    fileprivate lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16.0
        stackView.addArrangedSubview(self.categoryTextField)
        stackView.addArrangedSubview(self.accountTextField)
        return stackView
    }()

    fileprivate lazy var categoryTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.tag = TextFieldTag.category.rawValue
        textField.hasBottomBorder = true
        textField.placeholder = "Categoria"
        textField.tintColor = .lightGray
        textField.returnKeyType = .next
        textField.delegate = self
        return textField
    }()

    fileprivate lazy var accountTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.tag = TextFieldTag.account.rawValue
        textField.placeholder = "Conta"
        textField.hasBottomBorder = true
        textField.tintColor = .lightGray
        textField.returnKeyType = .next
        textField.delegate = self
        return textField
    }()

    private lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()

    fileprivate let viewModel = AddTransactionViewModel(state: .income)

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        valueTextField.becomeFirstResponder()
    }

    override func loadView() {
        super.loadView()
        setupView()
    }

    private func bindViewModel() {
        viewModel.stateProperty.signal
            .observeValues { [unowned self] (newState) in
                let color: UIColor
                switch newState {
                case .income: color = UIColor(r: 33, g: 199, b: 209)
                case .outcome: color = UIColor.red
                case .transfer: color = UIColor.blue
                }

                self.navigationController?.navigationBar.barTintColor = color
                self.headerBackgroundView.backgroundColor = color
        }

        viewModel.value
            .observeValues { [unowned self] (value) in
                if value == 0 {
                    self.valueTextField.text = nil
                } else {
                    self.valueTextField.text = self.numberFormatter.string(from: value as NSNumber)
                }
        }
    }

    @objc fileprivate func transactionTypeChanged(_ sender: UISegmentedControl) {
        viewModel.transactionTypeChanged(to: sender.selectedSegmentIndex)
    }

    @objc fileprivate func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @objc fileprivate func doneTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension AddTransactionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let tag = TextFieldTag(rawValue: textField.tag) else { return true }
        switch tag {
        case .value:
            return viewModel.valueTextField(shouldChangeCharactersIn: range, replacementString: string)
        default:
            return true
        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let field = TextFieldTag(rawValue: textField.tag) else { return false }

        switch field {
        case .category:
            print("Push VC")
            return false
        default:
            return true
        }
    }
}

extension AddTransactionViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(headerBackgroundView)
        headerBackgroundView.addSubview(moveTypeSegmentedControl)
        headerBackgroundView.addSubview(valueTextField)
        view.addSubview(stackView)
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

        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(headerBackgroundView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
    }

    func configureView() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self, action: #selector(cancelTapped(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self, action: #selector(doneTapped(_:)))
    }
}
