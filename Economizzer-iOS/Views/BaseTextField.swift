//
//  RightIconTextField.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 06/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {

    var rightIcon: UIImage? {
        didSet {
            if let rightIcon = rightIcon {
                rightView = UIImageView(image: rightIcon)
                rightView?.contentMode = .scaleAspectFit
                rightViewMode = .always
            } else {
                rightView = nil
            }
        }
    }

    var hasBottomBorder: Bool = false {
        didSet {
            if hasBottomBorder {
                self.borderStyle = .none
                self.layer.backgroundColor = UIColor.white.cgColor

                self.layer.masksToBounds = false
                self.layer.shadowColor = UIColor.lightGray.cgColor
                self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                self.layer.shadowOpacity = 0.5
                self.layer.shadowRadius = 0.0
            }
        }
    }
}
