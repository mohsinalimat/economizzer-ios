//
//  GeneralSectionHeaderView.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 05/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit

final class GeneralSectionHeaderView: UICollectionReusableView {
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    var title: String? {
        didSet {
            titleLabel.text = title
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


extension GeneralSectionHeaderView: ViewConfigurator {
    func buildViewHierarchy() {
        addSubview(titleLabel)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
    }

    func configureView() {
//        backgroundColor = .black
    }
}
