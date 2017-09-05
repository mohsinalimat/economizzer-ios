//
//  GeneralBalanceSectionController.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 04/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import Foundation
import IGListKit

final class GeneralBalanceSectionController: ListSectionController {

    private var object: GeneralBalanceViewModel?

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 196)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: GeneralBalanceCollectionViewCell.self, for: self, at: index) as? GeneralBalanceCollectionViewCell else {
            fatalError("Could not dequeue cell.")
        }

        cell.viewModel = object

        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? GeneralBalanceViewModel
    }

    override func didSelectItem(at index: Int) {

    }
}
