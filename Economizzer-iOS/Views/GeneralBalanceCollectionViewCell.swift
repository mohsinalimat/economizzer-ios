//
//  GeneralBalanceCollectionViewCell.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 04/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit
import SnapKit

final class GeneralBalanceCollectionViewCell: UICollectionViewCell {

    fileprivate lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()

    fileprivate lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()

    fileprivate lazy var generalBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "saldo geral"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        return label
    }()

    var viewModel: GeneralBalanceViewModel? {
        didSet {
            updateLayout()
        }
    }

    fileprivate var data: [CGFloat] = [] {
        didSet {
            updateGraph()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("This class shoud only be initiated programatically.")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let path = UIBezierPath()

        let startPoint = CGPoint(x: rect.minX, y: rect.maxY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.maxY)

        var xPoint: CGFloat = 0
        let xStep: CGFloat = rect.width / CGFloat(data.count - 1)

        path.move(to: startPoint)

        if let maxValue = data.max() {
            for value in data {
                path.addLine(to: CGPoint(x: xPoint, y: rect.height - (value*rect.height/maxValue)))
                xPoint += xStep
            }
        }

        path.addLine(to: endPoint)
        path.addLine(to: startPoint)

        path.close()

        UIColor(r: 30, g: 189, b: 200).set()
        path.fill()
    }

    private func updateLayout() {
        guard let viewModel = viewModel else {
            return
        }

        greetingLabel.text = viewModel.greeting
        balanceLabel.text = "R$ \(viewModel.balance)"
        data = viewModel.graphData
    }

    private func updateGraph() {
        setNeedsLayout()
        layoutIfNeeded()
    }

}

extension GeneralBalanceCollectionViewCell: ViewConfigurator {
    func buildViewHierarchy() {
        contentView.addSubview(greetingLabel)
        contentView.addSubview(balanceLabel)
        contentView.addSubview(generalBalanceLabel)
    }

    func setupConstraints() {
        balanceLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        greetingLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(balanceLabel)
            make.bottom.equalTo(balanceLabel.snp.top).offset(-18)
        }

        generalBalanceLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(balanceLabel)
            make.top.equalTo(balanceLabel.snp.bottom).offset(12)
        }
    }

    func configureView() {
        backgroundColor = UIColor(r: 33, g: 199, b: 209)
    }
}
