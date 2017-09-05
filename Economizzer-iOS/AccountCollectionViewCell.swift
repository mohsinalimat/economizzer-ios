//
//  AccountCollectionViewCell.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 05/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit

final class AccountCollectionViewCell: UICollectionViewCell {

    fileprivate lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()

    fileprivate lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        return view
    }()

    var isSeparatorHidden: Bool = false {
        didSet {
            separatorView.isHidden = isSeparatorHidden
        }
    }

    var viewModel: AccountCellViewModel? {
        didSet {
            iconImageView.image = viewModel?.iconImage
            nameLabel.text = viewModel?.accountName
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("This class should only be instantiated programatically.")
    }
}

extension AccountCollectionViewCell: ViewConfigurator {
    func buildViewHierarchy() {
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(separatorView)
    }

    func setupConstraints() {
        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-24)
        }

        separatorView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.left.equalTo(iconImageView).offset(-4)
            make.right.equalTo(nameLabel).offset(4)
        }
    }

    func configureView() {
//        backgroundColor = .blue
    }
}
